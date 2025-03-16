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
          user='appclient',
          # Find port in MAMP or MySQL Workbench GUI or with
          # SHOW VARIABLES WHERE variable_name LIKE 'port';
          port='3306',  # this may change!
          password='clientpw',
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
# CLIENT (Adopter) FUNCTION STUBS
# ----------------------------------------------------------------------
def register_adopter(name, address, email, phone, password, date_joined, waitlist_number=None):
    """
    Registers a new adopter in the adopters table.

    Args:
        name (str): Full name of the adopter.
        address (str): Adopter's address.
        email (str): Adopter's email address.
        phone (str): Adopter's phone number.
        password (str): Password (should be hashed in production).
        date_joined (str): Date the adopter joined (YYYY-MM-DD).
        waitlist_number (int, optional): The waitlist number if applicable.

    Returns:
        bool: True if registration was successful, False otherwise.
    """
    sql = """
        INSERT INTO adopters (name, address, email, phone, password, date_joined, waitlist_number)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    """
    result = run_query(sql, (name, address, email, phone, password, date_joined, waitlist_number))
    return bool(result)

def view_available_animals():
    """
    Retrieves a list of animals currently available for adoption (not yet adopted).
    
    Returns:
        list: A list of tuples containing animal data, or None on failure.
    """
    sql = "SELECT * FROM animals WHERE animal_id NOT IN (SELECT animal_id FROM adoptions);"
    rows = run_query(sql)
    return rows

def view_animal_details(animal_id):
    """
    Retrieves detailed information for a specific animal by ID.

    Args:
        animal_id (int): The ID of the animal.

    Returns:
        tuple: The details of the requested animal, or None if not found.
    """
    sql = "SELECT * FROM animals WHERE animal_id = %s;"
    rows = run_query(sql, (animal_id,))
    return rows[0] if rows else None


def search_animals(breed=None, age=None):
    """
    Searches for animals by breed and/or age.

    Args:
        breed (str, optional): Breed to search for.
        age (int, optional): Age to search for.

    Returns:
        list: A list of tuples of animals matching the criteria, or None on failure.
    """
    sql = "SELECT * FROM animals WHERE 1=1"
    params = []
    if breed:
        sql += " AND breed = %s"
        params.append(breed)
    if age is not None:
        sql += " AND age = %s"
        params.append(age)
    rows = run_query(sql, tuple(params))
    return rows

def find_animals_by_distance(user_zip):
    """
    Finds available animals sorted by their distance from the given location.

    This function calculates the distance between the user's current zip code
    and the location of each shelter (which houses the animal).
    It returns the list of available animals in ascending order of distance.

    Args:
        user_zip (int): users zip code

    Returns:
        list: A list of tuples/dictionaries containing animal details and computed distance.
              The distance is in kilometers.
    """
    sql = """
        SELECT animals.*, shelters.zip_code,
               ABS(shelters.zip_code - %s) AS zip_diff
        FROM animals
        JOIN shelters ON animals.shelter_id = shelters.shelter_id
        WHERE animals.animal_id NOT IN (SELECT animal_id FROM adoptions)
        ORDER BY zip_diff ASC;
    """
    params = (adopter_zip,)
    rows = run_query(sql, params)
    return rows

def submit_adoption_request(adopter_id, animal_id):
    """
    Submits an adoption request for a specific animal.

    Args:
        adopter_id (int): ID of the adopter requesting the adoption.
        animal_id (int): ID of the animal to adopt.

    Returns:
        bool: True if request was successfully recorded, False otherwise.
    """
    sql = """
        INSERT INTO Adoption_Requests (adopter_id, animal_id, request_date)
        VALUES (%s, %s, NOW());
    """
    result = run_query(sql, (adopter_id, animal_id))
    return bool(result)

def view_adoption_history(adopter_id):
    """
    Retrieves all past adoptions for a specific adopter.

    Args:
        adopter_id (int): The ID of the adopter.

    Returns:
        list: A list of tuples containing adoption and animal details, or None on failure.
    """
    sql = """
        SELECT adoptions.*, animals.name, animals.breed
        FROM adoptions
        JOIN animals ON adoptions.animal_id = animals.animal_id
        WHERE adopter_id = %s;
    """
    rows = run_query(sql, (adopter_id,))
    return rows

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
        # rows[0] might look like (5,) if not using dictionary=True, or {'count': 5} if dictionary cursor
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
        SELECT AVG(DATEDIFF(date_taken, intake_date)) AS avg_stay
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

def client_menu():
    print("\n========== Adopter (User) Menu ==========")
    print("1. Register as a new adopter")
    print("2. View all available animals")
    print("3. View details for a specific animal")
    print("4. Search animals by breed/age")
    print("5. Submit an adoption request")
    print("6. View your adoption history")
    print("q. Quit")
    while True:
        choice = input("\nSelect an option: ").strip().lower()
        if choice == '1':
            register_adopter()
        elif choice == '2':
            view_available_animals()
        elif choice == '3':
            view_animal_details()
        elif choice == '4':
            search_animals()
        elif choice == '5':
            submit_adoption_request()
        elif choice == '6':
            view_adoption_history()
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
    client_menu()
    conn.close()


if __name__ == '__main__':
    main()
