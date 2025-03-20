"""
Student name(s): Sujit Iyer and Brendan Flaherty
Student email(s): siyer2@caltech.edu and bflahert@caltech.edu
High-level program overview: This program provides functionality
for animal shelter database staff. They can add/manage shelters,
animals, and validate adoptions.
******************************************************************************
"""
# TODO: Make sure you have these installed with pip3 if needed
import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode
from datetime import datetime

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. ***Set to False when done testing.***
DEBUG = False

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
    global conn
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='animaladmin',
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
            sys.stderr.write('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr.write('Database does not exist.')
        elif DEBUG:
            sys.stderr.write(err)
        else:
            # A fine catchall message.
            sys.stderr.write('An error occurred.')
        sys.exit(1)

def run_query(sql, params=()):
    """
    Helper function to execute an SQL query with the global connection.
    Abstracts away cursor handling and error handling.
    """
    cursor = conn.cursor()
    try:
        cursor.execute(sql, params)
        if cursor.description: 
            rows = cursor.fetchall()
            return rows
        conn.commit() # had to use this for the sp_add_staff function to actually make changes
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
# ADMIN FUNCTIONS
# ----------------------------------------------------------------------
def register_admin():
    """
    Prompts for staff information and registers new staff.
    Uses sp_add_staff defined in setup-passwords.sql
    """
    print("=== Register as a New Employee ===")
    new_email = input("Enter email: ")
    new_password = input("Enter password: ")
    new_firstname = input("Enter first name: ")
    new_lastname = input("Enter last name: ")
    new_role = input("Enter role (Admin/Manager/etc): ")
    new_phone = input("Enter phone number: ")

    sql = """CALL sp_add_staff(%s, %s, %s, %s, %s, %s);"""
    result = run_query(sql, (new_email, new_password, new_firstname, new_lastname, new_role, new_phone))
    if result:
        print("\nRegistration successful!\n")
    return bool(result)

def login_admin():
    """
    Prompts the user for email and password to log in.
    Uses authenticate_staff function to validate credentials.
    """
    print("=== Admin Login ===")
    email = input("Email: ")
    password = input("Password: ")
    
    # Call the MySQL authentication function
    sql = "SELECT authenticate_staff(%s, %s);"
    result = run_query(sql, (email, password))

    if result and result[0][0] != 0:
        staff_id = result[0][0]  # Extract the staff_id
        print("\nLogin successful!\n")
        return staff_id

    print("\nLogin failed. Please check your credentials.\n")
    return None

def change_staff_password():
    """
    Prompts the staff member for their email and a new password.
    Calls the stored procedure sp_change_staff_password to update the password.
    """
    print("\n=== Change Staff Password ===")

    email = input("Enter your email: ").strip()
    if not email:
        print("\nEmail cannot be empty.\n")
        return

    new_password = input("Enter new password: ").strip()
    if not new_password:
        print("\nPassword cannot be empty.\n")
        return

    sql = "CALL sp_change_staff_password(%s, %s);"
    result = run_query(sql, (email, new_password))

    if result:
        print("\nPassword changed successfully!\n")
    else:
        print("\nFailed to change password. Please try again.\n")

def add_animal():
    """
    Calls the stored procedure add_animal to add a new animal to the database.
    """
    name = input("Enter animal name: ")
    breed = input("Enter breed: ")
    try:
        age = int(input("Enter age: "))
    except ValueError:
        print("Invalid age.")
        return
    gender = input("Enter gender (M, F, U): ")
    intake_date = input("Enter intake date (YYYY-MM-DD): ")
    try:
        datetime.strptime(intake_date, "%Y-%m-%d")
    except ValueError:
        print("Invalid date format. Use YYYY-MM-DD.")
        return
    try:
        shelter_id = int(input("Enter shelter ID: "))
    except ValueError:
        print("Invalid shelter ID.")
        return
    sql = "CALL add_animal(%s, %s, %s, %s, %s, %s);"
    result = run_query(sql, (breed, name, age, gender, intake_date, shelter_id))
    if result:
        print("\nAnimal added successfully!\n")
    else:
        print("\nFailed to add animal. Check to make sure shelter id is valid.\n")
    return bool(result)

def add_shelter():
    """
    Calls the stored procedure add_shelter to add a new shelter to the database.
    """
    location = input("Enter shelter location: ")
    try:
        zip_code = int(input("Enter shelter zip code: "))
    except ValueError:
        print("Invalid zip code.")
        return
    try:
        staff_id = int(input("Enter managing staff ID: "))
    except ValueError:
        print("Invalid staff ID.")
        return
    sql = "CALL add_shelter(%s, %s, %s);"
    result = run_query(sql, (location, zip_code, staff_id))
    if result:
        print("\nShelter added successfully!\n")
    else:
        print("\nFailed to add shelter. Ensure managing staff ID is valid.\n")
    return bool(result)

def transfer_animal():
    """
    Calls the stored procedure transfer_animal to move an animal to a new shelter.
    """
    try:
        animal_id = int(input("Enter animal ID: "))
    except ValueError:
        print("Invalid animal ID.")
        return
    try:
        new_shelter_id = int(input("Enter shelter ID: "))
    except ValueError:
        print("Invalid shelter ID.")
        return
    sql = "CALL transfer_animal(%s, %s);"
    result = run_query(sql, (animal_id, new_shelter_id))
    if result:
        print("\nAnimal transferred successfully!\n")
    else:
        print("\nFailed to transfer animal. Make sure shelter ID and animal ID both exist.\n")
    return bool(result)

def get_current_adoption_requests():
    """
    Retrieves all current adoption requests.
    """
    sql = """
        SELECT ar.request_id, a.animal_id as animal_id, a.name AS animal_name, ad.adopter_id as adopter_id, ad.name AS adopter_name, ar.request_date
        FROM adoption_requests ar
        JOIN animals a ON ar.animal_id = a.animal_id
        JOIN adopters ad ON ar.adopter_id = ad.adopter_id
        ORDER BY ar.request_date DESC;
    """
    result = run_query(sql)   
    if result:
        headers = ["Request ID", "Animal ID", "Animal Name", "Adopter ID", "Adopter Name", "Request Date"]
        col_widths = [12, 10, 20, 10, 20, 15]
        print(" | ".join(header.ljust(width) for header, width in zip(headers, col_widths)))
        print("-" * sum(col_widths) + "-" * (len(headers) * 3))
        for row in result:
            print(" | ".join(str(item).ljust(width) for item, width in zip(row, col_widths)))
    else:
        print("\n No current adoption requests found.\n")

def approve_adoption():
    """
    Calls the stored procedure adopt_pet to process an adoption.
    """
    try:
        pet_id = int(input("Enter animal ID: "))
    except ValueError:
        print("Invalid animal ID.")
        return
    try:
        adopter_id = int(input("Enter adopter ID: "))
    except ValueError:
        print("Invalid adopter ID.")
        return
    sql = "CALL adopt_pet(%s, %s);"
    result = run_query(sql, (pet_id, adopter_id))
    if result:
        print("\nAdoption successful!.\n")
    else:
        print("\nAdoption failed. Make sure animal ID and adopter ID are both in adoption requests.\n")
    return bool(result)

def perform_medical_check():
    """
    Prompts the user for an animal ID and its new health status,
    then calls the update_health_status stored procedure to update the database.
    """
    try:
        animal_id = int(input("Enter Animal ID: "))
    except ValueError:
        print("Invalid Animal ID. Please enter a number.")
        return False

    health_status = input("Is the animal healthy? (yes/no): ").strip().lower()
    if health_status in ['yes', 'y']:
        new_health_status = 1
    elif health_status in ['no', 'n']:
        new_health_status = 0
    else:
        print("Invalid input. Please enter 'yes' or 'no'.")
        return False

    sql = "CALL update_health_status(%s, %s);"
    result = run_query(sql, (animal_id, new_health_status))

    if result:
        print("\nHealth status updated successfully!\n")
        return True
    else:
        print("\nFailed to update health status. Make sure animal id exists.\n")
        return False

def get_animals_per_shelter():
    """
    Retrieves the number of animals in each shelter.
    """
    sql = """
        SELECT s.shelter_id, s.location, COALESCE(COUNT(a.animal_id), 0) AS animal_count
        FROM shelters s
        LEFT JOIN animals a ON s.shelter_id = a.shelter_id
        GROUP BY s.shelter_id, s.location
        ORDER BY animal_count DESC;
    """
    rows = run_query(sql)
    if rows:
        print("\n=== Number of Animals per Shelter ===")
        for row in rows:
            print(f"Shelter ID: {row[0]}, Location: {row[1]}, Animal Count: {row[2]}")
    else:
        print("No shelters found.")

def get_most_adopted_breeds():
    """
    Retrieves the most frequently adopted animal breeds.
    SQL Query uses a view which joins animals and adoptions
    """
    sql = """
        SELECT breed, COUNT(adoption_date) AS adoption_count
        FROM adoption_overview
        WHERE adoption_date IS NOT NULL
        GROUP BY breed
        ORDER BY adoption_count DESC
        LIMIT 10;
    """
    rows = run_query(sql)
    if rows:
        print("\n=== Most Adopted Breeds ===")
        for row in rows:
            print(f"Breed: {row[0]}, Adoption Count: {row[1]}")
    else:
        print("No adoption data available.")

def get_adoptions_per_month():
    """
    Retrieves the number of adoptions per month.
    """
    sql = """
        SELECT DATE_FORMAT(ad.date_taken, '%Y-%m') AS adoption_month, COUNT(*) AS adoption_count
        FROM adoptions ad
        GROUP BY adoption_month
        ORDER BY adoption_month DESC;
    """
    rows = run_query(sql)
    if rows:
        print("\n=== Adoptions Per Month ===")
        for row in rows:
            print(f"Month: {row[0]}, Adoptions: {row[1]}")
    else:
        print("No adoption data available.")

def get_days_in_shelter():
    """
    Finds amount of time a specific animal has been in their shelter
    """
    try:
        animal_id = int(input("Enter Animal ID: "))
    except ValueError:
        print("Invalid Animal ID. Please enter a number.")
        return False
    sql = "SELECT days_in_shelter(%s);"
    rows = run_query(sql, (animal_id,))
    if rows and rows[0][0] != 0:
        print(rows[0][0], "days")
    else:
        print("Animal not found.")

# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------
def show_options(staff_id):
    while True:
        print("\n========== Admin Menu ==========")
        print("1. Add a new animal")
        print("2. Add a new shelter")
        print("3. Check adoption requests")
        print("4. Approve an adoption")
        print("5. Perform medical check")
        print("6. Check shelter animal counts")
        print("7. Find breed adoption counts")
        print("8. Check adoptions per month")
        print("9. Check animal time in shelter")
        print("q. Logout/Exit")
        choice = input("\nSelect an option: ").strip().lower()
        if choice == '1':
            add_animal()
        elif choice == '2':
            add_shelter()
        elif choice == '3':
            get_current_adoption_requests()
        elif choice == '4':
            approve_adoption()
        elif choice == '5':
            perform_medical_check()
        elif choice == '6':
            get_animals_per_shelter()
        elif choice == '7':
            get_most_adopted_breeds()
        elif choice == '8':
            get_adoptions_per_month()
        elif choice == '9':
            get_days_in_shelter()
        elif choice == 'q':
            quit_ui()
        else:
            print("Invalid option. Please try again.")


def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Goodbye!')
    if conn:
        conn.close()
    exit()


def main():
    global conn
    conn = get_conn()
    while True:
        print("\n====== Welcome to the Animal Shelter App ======")
        print("1. Login as an Administrator")
        print("2. Register as new Staff")
        print("3. Change your password")
        print("q. Quit")
        choice = input("Select an option: ").strip().lower()
        if choice == '1':
            staff_id = login_admin()
            print("Your ID: ", staff_id)
            if staff_id:
                show_options(staff_id)
        elif choice == '2':
            register_admin()
        elif choice == '3':
            change_staff_password()
        elif choice == 'q':
            quit_ui()
        else:
            print("Unknown option.")
    conn.close()

if __name__ == '__main__':
    main()
