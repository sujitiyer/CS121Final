"""
Student name(s): Sujit Iyer and Brendan Flaherty
Student email(s): siyer2@caltech.edu and bflahert@caltech.edu
High-level program overview: This program provides functionality
for an animal shelter database. The program's purpose is to connect
potential adopters with animals in shelters. It also allows
adopters to perform due-diligence before adoption.
******************************************************************************
"""
# TODO: Make sure you have these installed with pip3 if needed
import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. ***Set to False when done testing.***
DEBUG = True

# Global connection (initialized in __main__ block)
conn = None

# ----------------------------------------------------------------------
# SQL Utility Functions
# ----------------------------------------------------------------------
def get_conn():
    """"
    Returns a connected MySQL connector instance, if connection is successful.
    If unsuccessful, exits.
    """
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='appadmin',
          # Find port in MAMP or MySQL Workbench GUI or with
          # SHOW VARIABLES WHERE variable_name LIKE 'port';
          port='3306',  # this may change!
          password='adminpw',
          database='shelterdb' # replace this with your database name
        )
        print('Successfully connected.')
        return conn
    except mysql.connector.Error as err:
        # Remember that this is specific to _database_ users, not
        # application users. So is probably irrelevant to a client in your
        # simulated program. Their user information would be in a users table
        # specific to your database; hence the DEBUG use.
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR and DEBUG:
            sys.stderr('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr('Database does not exist.')
        elif DEBUG:
            sys.stderr(err)
        else:
            # A fine catchall client-facing message.
            sys.stderr('An error occurred, please contact the administrator.')
        sys.exit(1)

def run_query(sql, params=()):
    """
    Helper function to execute an SQL query with the global connection.
    Abstracts away cursor handling, commits, and error handling.
    
    Args:
        sql (str): SQL query string with %s placeholders.
        params (tuple): Parameters for the SQL query.
    
    Returns:
        list or bool: 
            - If the query returns rows (e.g. SELECT), returns a list of tuples.
            - If the query is DML (INSERT/UPDATE/DELETE), returns True if successful.
            - Returns None on failure.
    """
    cursor = conn.cursor()
    try:
        cursor.execute(sql, params)
        if cursor.description: 
            rows = cursor.fetchall()
            return rows
        return True
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr.write(f"SQL Error: {err}\n")
            sys.exit(1)
        else:
            sys.stderr.write("An error occurred, please contact support.\n")
            return None
    finally:
        cursor.close()

# ----------------------------------------------------------------------
# ADMIN FUNCTION STUBS
# ----------------------------------------------------------------------
def add_animal(breed, name, age, gender, intake_date, shelter_id):
    """
    Adds a new animal to the database.

    Args:
        breed (str): Breed of the animal.
        name (str): Name of the animal.
        age (int): Age of the animal.
        gender (str): Gender of the animal.
        intake_date (str): Date of intake (YYYY-MM-DD).
        shelter_id (int): ID of the shelter where the animal is located.

    Returns:
        bool: True if the animal was added successfully, False otherwise.
    """
    sql = """
        INSERT INTO animals (breed, name, age, gender, intake_date, shelter_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    """
    result = run_query(sql, (breed, name, age, gender, intake_date, shelter_id))
    return bool(result)

def update_animal(animal_id, updated_fields):
    """
    Updates details of an existing animal in the database.

    Args:
        animal_id (int): The ID of the animal to update.
        updated_fields (dict): Dictionary of fields to update. e.g. {'name': 'Max'}

    Returns:
        bool: True if the update was successful, False otherwise.
    """
    set_clause = ', '.join([f"{key} = %s" for key in updated_fields.keys()])
    sql = f"UPDATE animals SET {set_clause} WHERE animal_id = %s;"
    params = tuple(updated_fields.values()) + (animal_id,)
    result = run_query(sql, params)
    return bool(result)

def delete_animal(animal_id):
    """
    Deletes an animal from the database.

    Args:
        animal_id (int): The ID of the animal to delete.

    Returns:
        bool: True if deletion was successful, False otherwise.
    """
    sql = "DELETE FROM animals WHERE animal_id = %s AND animal_id NOT IN (SELECT animal_id FROM adoptions);"
    result = run_query(sql, (animal_id,))
    return bool(result)

def add_shelter(location, zip_code, staff_id):
    """
    Adds a new shelter to the database.

    Args:
        location (str): The location/address of the shelter.
        zip_code (int): THe zip code of the shelter.
        staff_id (int): The ID of the staff member who manages this shelter.

    Returns:
        bool: True if the shelter was added successfully, False otherwise.
    """
    sql = """
        INSERT INTO shelters (location, zip_code, staff_id)
        VALUES (%s, %s, %s);
    """
    result = run_query(sql, (location, zip_code, staff_id))
    return bool(result)

def update_shelter(shelter_id, updated_fields):
    """
    Updates details of a specific shelter.

    Args:
        shelter_id (int): The ID of the shelter to update.
        updated_fields (dict): Fields to update. e.g. {'location': '123 Main St'}

    Returns:
        bool: True if update was successful, False otherwise.
    """
    set_clause = ', '.join([f"{key} = %s" for key in updated_fields.keys()])
    sql = f"UPDATE shelters SET {set_clause} WHERE shelter_id = %s;"
    params = tuple(updated_fields.values()) + (shelter_id,)
    result = run_query(sql, params)
    return bool(result)

def delete_shelter(shelter_id):
    """
    Deletes a shelter from the database.

    Args:
        shelter_id (int): The ID of the shelter to delete.

    Returns:
        bool: True if deletion was successful, False otherwise.
    """
    sql = "DELETE FROM shelters WHERE shelter_id = %s AND shelter_id NOT IN (SELECT shelter_id FROM animals);"
    result = run_query(sql, (shelter_id,))
    return bool(result)

def add_staff(first_name, last_name, role, phone_number, email, password):
    """
    Adds a new staff member to the database.

    Args:
        first_name (str): staff member's first name.
        last_name (str): staff member's last name.
        role (str): The role of the staff member (e.g., 'admin', 'manager').
        phone_number (str): Contact phone number.
        email (str): Staff member's email address.
        password (str): Staff member's password (should be hashed in production).

    Returns:
        bool: True if staff member was added successfully, False otherwise.
    """
    sql = """
        INSERT INTO staff (first_name, last_name, role, phone_number, email, password)
        VALUES (%s, %s, %s, %s, %s, %s);
    """
    result = run_query(sql, (first_name, last_name, role, phone_number, email, password))
    return bool(result)

# ----------------------------------------------------------------------
# REPORTS & ANALYTICS
# ----------------------------------------------------------------------
def get_shelter_animal_count(shelter_id):
    """
    Retrieves the number of animals in a given shelter.

    Args:
        shelter_id (int): The ID of the shelter.

    Returns:
        int: The count of animals in that shelter.
    """
    sql = "SELECT COUNT(*) AS count FROM animals WHERE shelter_id = %s;"
    rows = run_query(sql, (shelter_id,))
    if rows:
        return rows[0][0]
    return 0

def get_adoptions_over_time(start_date, end_date):
    """
    Analyzes adoption trends between two dates.

    Args:
        start_date (str): Start date in 'YYYY-MM-DD' format.
        end_date (str): End date in 'YYYY-MM-DD' format.

    Returns:
        list: A list of tuples representing adoptions grouped by day/month.
    """
    # Example grouping by day, adjust as needed (e.g., monthly grouping)
    sql = """
        SELECT DATE(date_taken) AS adoption_date, COUNT(*) AS adoption_count
        FROM adoptions
        WHERE date_taken BETWEEN %s AND %s
        GROUP BY DATE(date_taken)
        ORDER BY adoption_date;
    """
    rows = run_query(sql, (start_date, end_date))
    return rows

def get_most_adopted_breeds():
    """
    Identifies the most frequently adopted breeds.

    Returns:
        list: A list of tuples with breed and the number of adoptions, sorted by descending count.
    """
    sql = """
        SELECT animals.breed, COUNT(*) AS breed_count
        FROM adoptions
        JOIN animals ON adoptions.animal_id = animals.animal_id
        GROUP BY animals.breed
        ORDER BY breed_count DESC;
    """
    rows = run_query(sql)
    return rows

def get_average_animal_stay_time():
    """
    Calculates the average duration (in days) an animal stays before adoption.

    Returns:
        float or None: The average stay time in days, or None if no data is available.
    """
    sql = """
        SELECT COALESCE(AVG(DATEDIFF(date_taken, intake_date)), 0) AS avg_stay
        FROM animals
        JOIN adoptions ON animals.animal_id = adoptions.animal_id;
    """
    rows = run_query(sql)
    if rows:
        return rows[0][0]  # e.g., (15.2,)
    return None

# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------
def admin_menu():
    print("\n========== Admin Menu ==========")
    print("1. Add a new animal")
    print("2. Update animal details")
    print("3. Delete an animal")
    print("4. Add a new shelter")
    print("5. Update shelter details")
    print("6. Delete a shelter")
    print("7. Add a new staff member")
    print("8. Run Reports & Analytics")
    print("q. Logout/Exit")
    while True:
        choice = input("\nSelect an option: ").strip().lower()
        
        # TODO: Add logic
        if choice == '1':
            add_animal()
        elif choice == '2':
            update_animal()
        elif choice == '3':
            delete_animal()
        elif choice == '4':
            add_shelter()
        elif choice == '5':
            update_shelter()
        elif choice == '6':
            delete_shelter()
        elif choice == '7':
            add_staff()
        elif choice == '8':
            # run_reports() Develop this function more later
            # How should we handle reports and analytics
            # Potentially a shared file between users and admin
        elif choice == 'q':
            quit_ui()
        else:
            print("Invalid option. Please try again.")



def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Good bye!')
    exit()


def main():
    conn = get_conn()
    admin_menu()
    conn.close()

if __name__ == '__main__':
    main()
