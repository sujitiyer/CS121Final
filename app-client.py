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
from datetime import datetime

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
    global conn
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='animalclient',
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
            sys.stderr.write("An error occurred.\n")
            return None
    finally:
        cursor.close()

# ----------------------------------------------------------------------
# CLIENT (Adopter) FUNCTIONS
# ----------------------------------------------------------------------
def register_adopter():
    """
    Prompts for adopter information and registers a new adopter.
    Uses sp_add_adopter defined in setup-passwords.sql
    """
    print("=== Register as a New Adopter ===")
    new_email = input("Enter email: ")
    new_password = input("Enter password: ")
    new_name = input("Enter name: ")
    new_address = input("Enter address: ")
    new_zipcode = int(input("Enter zipcode: "))
    new_phone = input("Enter phone number: ")
    new_date_joined = input("Enter date joined (YYYY-MM-DD): ")

    try:
        new_date_joined = datetime.strptime(new_date_joined, "%Y-%m-%d").date()
    except ValueError:
        print("Invalid date format. Use YYYY-MM-DD.")
        return False

    sql = """CALL sp_add_adopter(%s, %s, %s, %s, %s, %s, %s);"""
    result = run_query(sql, (new_email, new_password, new_name, new_address, new_zipcode, new_phone, new_date_joined))
    if result:
        print("Registration successful!")
    else:
        print("Registration failed.")
    return bool(result)

def login_adopter():
    """
    Prompts the user for email and password to log in.
    Uses authenticate_adopter function to validate credentials.
    """
    print("=== Adopter Login ===")
    email = input("Email: ")
    password = input("Password: ")
    
    # Call the MySQL authentication function
    sql = "SELECT authenticate_adopter(%s, %s);"
    result = run_query(sql, (email, password))

    if result and result[0][0] is not None:
        adopter_id = result[0][0]  # Extract the adopter_id
        print("Login successful!")
        return adopter_id

    print("Login failed. Please check your credentials.")
    return None


def view_available_animals():
    """
    Displays animals currently available for adoption.
    """
    sql = "SELECT * FROM animals WHERE is_available = 1;"
    rows = run_query(sql)
    if rows:
        for row in rows:
            print(row)
    else:
        print("No available animals found.")

def view_animal_details():
    """
    Prompts for an animal ID and displays its details.
    """
    try:
        animal_id = int(input("Enter Animal ID: "))
    except ValueError:
        print("Invalid input.")
        return
    sql = "SELECT * FROM animals WHERE animal_id = %s;"
    rows = run_query(sql, (animal_id,))
    if rows:
        print(rows[0])
    else:
        print("Animal not found.")

def search_animals():
    """
    Searches for animals by breed and/or age range (-2 to +2 of target age).
    """
    breed = input("Enter breed (or leave blank): ")
    age_input = input("Enter target age (or leave blank): ")
    age = int(age_input) if age_input.isdigit() else None

    sql = "SELECT * FROM animals WHERE 1=1"
    params = []
    if breed:
        sql += " AND breed = %s"
        params.append(breed)
    if age is not None:
        sql += " AND age BETWEEN %s AND %s"
        params.append(age - 2)
        params.append(age + 2)
    rows = run_query(sql, tuple(params))
    if rows:
        for row in rows:
            print(row)
    else:
        print("No matching animals found.")

def find_animals_by_distance(adopter_id):
    """
    This function calculates the distance between the user's current zip code
    and the location of each shelter (which houses the animal).
    It returns the list of available animals in ascending order of distance.
    """
    zip_sql = "SELECT zip_code FROM adopters WHERE adopter_id = %s;"
    zip_result = run_query(zip_sql, (adopter_id,))
    if not zip_result or zip_result[0][0] is None:
        print("Zip code not set.")
        return
    adopter_zip = zip_result[0][0] # unpack

    sql = """
        SELECT animals.*, shelters.zip_code,
               ABS(shelters.zip_code - %s) AS zip_diff
        FROM animals
        JOIN shelters ON animals.shelter_id = shelters.shelter_id
        WHERE animals.is_available = 1
        ORDER BY zip_diff ASC;
    """
    params = (adopter_zip,)
    rows = run_query(sql, params)
    if rows:
        for row in rows:
            print(row)
    else:
        print("No animals found nearby.")

def submit_adoption_request(adopter_id):
    """
    Calls the submit_adoption_request procedure to record an adoption request.
    """
    sql = """
        INSERT INTO adoption_requests (adopter_id, animal_id, request_date)
        VALUES (%s, %s, NOW());
    """
    try:
        animal_id = int(input("Enter the Animal ID for the adoption request: "))
    except ValueError:
        print("Invalid Animal ID.")
        return
    sql = "CALL submit_adoption_request(%s, %s);"
    result = run_query(sql, (adopter_id, animal_id))
    if result:
        print("Adoption request submitted successfully!")
    else:
        print("Failed to submit adoption request.")

def view_adoption_history(adopter_id):
    """
    Retrieves all past adoptions for a specific adopter.
    SQL Query uses a view which joins animals and adoptions
    """
    sql = """
        SELECT animal_id, animal_name, breed, age, gender, adoption_date
        FROM adoption_overview
        WHERE adopter_id = %s
        ORDER BY adoption_date DESC;
    """
    adoptions = run_query(sql, (adopter_id,))
    if adoptions:
        for adoption in adoptions:
            print(adoptions)
    else:
        print("No adoption history found.")

# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------

def show_options(adopter_id):
    while True:
        print("\n========== Adopter Menu ==========")
        print("1. View all available animals")
        print("2. View details for a specific animal")
        print("3. Search animals by breed/age")
        print("4. Find animals near you")
        print("5. Submit an adoption request")
        print("6. View your adoption history")
        print("q. Log out")
        choice = input("\nSelect an option: ").strip().lower()
        if choice == '1':
            view_available_animals()
        elif choice == '2':
            view_animal_details()
        elif choice == '3':
            search_animals()
        elif choice == '4':
            find_animals_by_distance(adopter_id)
        elif choice == '5':
            submit_adoption_request(adopter_id)
        elif choice == '6':
            view_adoption_history(adopter_id)
        elif choice == 'q':
            quit_ui()
        else:
            print("Unknown option.")


def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Good bye!')
    if conn:
        conn.close()
    exit()


def main():
    global conn
    conn = get_conn()
    while True:
        print("\n====== Welcome to the Animal Shelter App ======")
        print("1. Login as an adopter")
        print("2. Register as a new adopter")
        print("q. Quit")
        choice = input("Select an option: ").strip().lower()
        if choice == '1':
            adopter_id = login_adopter()
            if adopter_id:
                show_options(adopter_id)
        elif choice == '2':
            register_adopter()
        elif choice == 'q':
            quit_ui()
        else:
            print("Unknown option.")
    conn.close()


if __name__ == '__main__':
    main()