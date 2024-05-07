# Use Case 5, using python's mysqlconnector to connect to the database
# Using 4 combinations between correct/incorrect username and passwords, check if the user is in the database and if authentication is succesful

import mysql.connector

# Connect to MySQL localhost
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="beef_noodles_3"
)

# Check if the connection is successful
if cnx.is_connected():
    print("Connection to database successful.\n")

# Sample input username and password
# Correct username and password
correct_property_owner_name = "Flinn Linham"
correct_property_owner_password = "qT9)ftOuU"
# Incorrect username and correct password
wrong_property_owner_name = "wrongname"
wrong_property_owner_password = "wrongpassword"

'''
Function to authenticate the user
Input: cnx - connection to the database
         username - username of the user
            password - password of the user
'''


def authenticate_user(cnx, username, password):
    # Authentication
    cursor = cnx.cursor()

    # Print to CLI the username and password
    print("Username: ", username)
    print("Password: ", password)

    # Check if user is in the database
    cursor.execute(
        "SELECT * FROM property_owner WHERE user_name = %s", (username,))
    # Fetch the result
    user = cursor.fetchone()

    if user is None:
        print("User not found.")
    else:
        # Check if the password is correct
        cursor.execute(
            "SELECT * FROM property_owner WHERE user_name = %s AND user_password = %s", (username, password))
        user = cursor.fetchone()
        if user is None:
            print("User exists but password is incorrect")
        else:
            print("User exists and password is correct")

    print()

# Correct username and correct password
authenticate_user(cnx, correct_property_owner_name,
                  correct_property_owner_password)
# Correct username and incorrect password
authenticate_user(cnx, correct_property_owner_name, wrong_property_owner_password)
# Incorrect username and correct password
authenticate_user(cnx, wrong_property_owner_name,
                  correct_property_owner_password)
# Incorrect username and incorrect password
authenticate_user(cnx, wrong_property_owner_name, wrong_property_owner_password)

# Close the connection
cnx.close()
