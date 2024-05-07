# **Explanation:**

## USE_CASE_1:
### Script: [use_case_1.sql](use_cases/use_case_1.sql)
This SQL script involves fetching the duration of the latest case for a given user id and property id, if available and the case is closed.

1. **Create Procedure**: The script starts by creating a new stored procedure `GetCaseDuration`. This procedure does not take any input parameters.

```sql
CREATE PROCEDURE GetCaseDuration()
```

2. **SQL Query**: Inside the procedure, it first checks if the user exists in the `property_owner` table. If the user exists, it executes a `SELECT` query to fetch the duration of the latest case for the given user id and property id. The duration is calculated as the difference between the `date_closed` and `date_opened` fields. If the `date_closed` field is null, it returns 'No closed date available'. If the user does not exist, it returns 'User does not exist'.

```sql
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists
    FROM property_owner -- Check property_owner table
    WHERE user_id = 299;

    IF user_exists > 0 THEN
        SELECT
            user_id,
            property_id,
            CASE
                WHEN date_closed IS NOT NULL THEN
                    CONCAT(
                        FLOOR(DATEDIFF(date_closed, date_opened) / 30), ' months, ',
                        FLOOR(DATEDIFF(date_closed, date_opened) % 30 / 7), ' weeks, ',
                        FLOOR(DATEDIFF(date_closed, date_opened) % 7), ' days, ',
                        FLOOR(TIME_TO_SEC(TIMEDIFF(date_closed, date_opened)) % 24), ' hours, ',
                        FLOOR(TIME_TO_SEC(TIMEDIFF(date_closed, date_opened)) % 3600 / 60), ' minutes'
                    )
                ELSE
                    'No closed date available'
            END AS duration -- Calculate duration
        FROM 
            cases -- Check cases table
        WHERE 
            user_id = 299 AND property_id = 1090;
    ELSE
        SELECT 'User does not exist' AS message;
    END IF;
END //
```

3. **Call Procedure**: After creating the procedure, the script calls it with no parameters.

```sql
CALL GetCaseDuration(); -- Call the procedure
```

4. **Drop Procedure**: Finally, the script drops the procedure `GetCaseDuration` after it has been executed.

```sql
DROP PROCEDURE IF EXISTS GetCaseDuration; -- Drop the procedure after use
```

This script is useful to fetch the duration of the latest case for a specific user and property, if the case is closed. The duration is returned in the format 'X months, Y weeks, Z days, A hours, B minutes'.

## USE_CASE_2:
### Script: [use_case_2.sql](use_cases/use_case_2.sql)
This SQL script involves fetching all properties in a given city along with their types and the user id of the owner.

1. **Drop Procedure if Exists**: The script starts by dropping the stored procedure `GetPropertiesByCity` if it already exists in the database. This is to ensure that the procedure is created fresh each time the script runs.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByCity;
```

2. **Create Procedure**: The script then creates a new stored procedure `GetPropertiesByCity`. This procedure takes one input parameter `city_name` of type `VARCHAR(16)`.

```sql
CREATE PROCEDURE GetPropertiesByCity(IN city_name VARCHAR(16))
```

3. **SQL Query**: Inside the procedure, it executes a `SELECT` query to fetch the properties in the given city. The query joins the `property`, `property_type`, and `property_owner` tables on their respective keys. It selects the `property_id`, `pType_id`, `pType_Desc`, `user_id`, `user_name`, and `city` fields. The `WHERE` clause filters the records where the `city` matches the input `city_name`.

```sql
BEGIN
    SELECT
        p.property_id,
        pt.pType_id,
        pt.pType_Desc,
        po.user_id,
        po.user_name,
        p.city
    FROM
        property p
    JOIN property_type pt ON p.pType_id = pt.pType_id
    JOIN property_owner po ON p.user_id = po.user_id
    WHERE
        p.city = city_name;
END //
```

4. **Call Procedure**: After creating the procedure, the script calls it with a sample city `"Kuching"` to fetch the properties in this city.

```sql
CALL GetPropertiesByCity('Kuching');
```

5. **Drop Procedure**: Finally, the script drops the procedure `GetPropertiesByCity` after it has been executed.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByCity;
```

This script is useful to fetch all properties in a specific city along with their types and the user id of the owner.

## USE_CASE_3:
### Script: [use_case_3.sql](use_cases/use_case_3.sql)
This SQL script involves fetching all properties owned by a user, identified by their email address, along with their types.

1. **Drop Procedure if Exists**: The script starts by dropping the stored procedure `GetPropertiesByEmail` if it already exists in the database. This is to ensure that the procedure is created fresh each time the script runs.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByEmail;
```

2. **Create Procedure**: The script then creates a new stored procedure `GetPropertiesByEmail`. This procedure takes one input parameter `email_address` of type `VARCHAR(64)`.

```sql
CREATE PROCEDURE GetPropertiesByEmail(IN email_address VARCHAR(64))
```

3. **SQL Query**: Inside the procedure, it executes a `SELECT` query to fetch the properties owned by the user with the given email address. The query joins the `property`, `property_type`, and `property_owner` tables on their respective keys. It selects the `property_id`, `pType_id`, `pType_Desc`, `user_id`, `user_name`, and `user_email` fields. The `WHERE` clause filters the records where the `user_email` matches the input `email_address`.

```sql
BEGIN
    SELECT
        p.property_id,
        pt.pType_id,
        pt.pType_Desc,
        po.user_id,
        po.user_name,
        po.user_email
    FROM
        property p
    JOIN property_type pt ON p.pType_id = pt.pType_id
    JOIN property_owner po ON p.user_id = po.user_id
    WHERE
        po.user_email = email_address;
END //
```

4. **Call Procedure**: After creating the procedure, the script calls it with a sample email address `"citzcovich8@weebly.com"` to fetch the properties owned by this user.

```sql
CALL GetPropertiesByEmail('citzcovich8@weebly.com');
```

5. **Drop Procedure**: Finally, the script drops the procedure `GetPropertiesByEmail` after it has been executed.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByEmail;
```

This script is useful to fetch all properties owned by a specific user, identified by their email address, along with their types.

## USE_CASE_4:
### Script: [use_case_4.sql](use_cases/use_case_4.sql)
This SQL script involves fetching all cases for properties of a property type based on the `date_closed` field from the `cases` table, along with the owner's name and email.

1. **Drop Procedure if Exists**: The script starts by dropping the stored procedure `GetCasesByDateClosed` if it already exists in the database. This is to ensure that the procedure is created fresh each time the script runs.

```sql
DROP PROCEDURE IF EXISTS GetCasesByDateClosed;
```

2. **Create Procedure**: The script then creates a new stored procedure `GetCasesByDateClosed`. This procedure takes one input parameter `date_closed_value` of type `DATE`.

```sql
CREATE PROCEDURE GetCasesByDateClosed(IN date_closed_value DATE)
```

3. **SQL Query**: Inside the procedure, it executes a `SELECT` query to fetch all cases for properties of a property type based on the `date_closed` field. The query joins the `cases`, `property`, `property_type`, `property_owner`, and `internal_staff` tables on their respective keys. It selects the `case_ref_id`, `user_id`, `user_name`, `user_email`, `staff_id`, `staff_name`, `pType_id`, `pType_Desc`, `case_Desc`, `staff_comment`, `date_opened`, and `date_closed` fields. The `WHERE` clause filters the records where the `date_closed` matches the input `date_closed_value` or both are `NULL`.

```sql
BEGIN
    SELECT
        c.case_ref_id,
        c.user_id,
        po.user_name,
        po.user_email,
        c.staff_id,
        s.staff_name,
        pt.pType_id,
        pt.pType_Desc,
        c.case_Desc,
        c.staff_comment,
        c.date_opened,
        c.date_closed
    FROM
        cases c
    JOIN property p ON c.property_id = p.property_id
    JOIN property_type pt ON p.pType_id = pt.pType_id
    JOIN property_owner po ON c.user_id = po.user_id
    JOIN internal_staff s ON c.staff_id = s.staff_id
    WHERE
        (c.date_closed = date_closed_value OR (date_closed_value IS NULL AND c.date_closed IS NULL));
END //
```

4. **Call Procedure**: After creating the procedure, the script calls it with `NULL` as the parameter to fetch the cases where `date_closed` is `NULL`.

```sql
CALL GetCasesByDateClosed(NULL);
```

5. **Drop Procedure**: Finally, the script drops the procedure `GetCasesByDateClosed` after it has been executed.

```sql
DROP PROCEDURE IF EXISTS GetCasesByDateClosed;
```

This script is useful to fetch all cases for properties of a property type based on the `date_closed` field from the `cases` table, along with the owner's name and email.

## USE_CASE_5:
### Script: [use_case_5.py](use_cases/use_case_6.sql)
This Python script involves authenticating a user by checking if the provided username and password exist in the `property_owner` table of the `beef_noodles_3` database.

1. **Establish Connection**: The script starts by establishing a connection to the MySQL database running on localhost.

```python
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="beef_noodles_3"
)
```

2. **Check Connection**: It then checks if the connection is successful.

```python
if cnx.is_connected():
    print("Connection to database successful.\n")
```

3. **Authenticate User**: The script defines a function `authenticate_user` that takes a connection, a username, and a password as parameters. It first checks if the username exists in the `property_owner` table. If the user exists, it then checks if the provided password matches the one in the database.

```python
def authenticate_user(cnx, username, password):
    cursor = cnx.cursor()
    cursor.execute(
        "SELECT * FROM property_owner WHERE user_name = %s", (username,))
    user = cursor.fetchone()

    if user is None:
        print("User not found.")
    else:
        cursor.execute(
            "SELECT * FROM property_owner WHERE user_name = %s AND user_password = %s", (username, password))
        user = cursor.fetchone()
        if user is None:
            print("User exists but password is incorrect")
        else:
            print("User exists and password is correct")
```

4. **Test Authentication**: The script then tests the `authenticate_user` function with four different combinations of correct and incorrect usernames and passwords.

```python
authenticate_user(cnx, correct_property_owner_name, correct_property_owner_password)
authenticate_user(cnx, correct_property_owner_name, wrong_property_owner_password)
authenticate_user(cnx, wrong_property_owner_name, correct_property_owner_password)
authenticate_user(cnx, wrong_property_owner_name, wrong_property_owner_password)
```

5. **Close Connection**: Finally, the script closes the connection to the database.

```python
cnx.close()
```

This script is useful for authenticating users by checking if their provided username and password exist in the `property_owner` table of the `beef_noodles_3` database.

## USE_CASE_6:
### Script: [use_case_6.sql](use_cases/use_case_5.py)
This SQL script involves fetching all properties owned by a user given their email address. The properties are fetched along with their types.

Here's a step-by-step explanation:

1. **Drop Procedure if Exists**: The script starts by dropping the stored procedure `GetPropertiesByUserEmail` if it already exists in the database. This is to ensure that the procedure is created fresh each time the script runs.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByUserEmail;
```

2. **Create Procedure**: The script then creates a new stored procedure `GetPropertiesByUserEmail`. This procedure takes one input parameter `user_email_value` of type `VARCHAR(100)`.

```sql
CREATE PROCEDURE GetPropertiesByUserEmail(IN user_email_value VARCHAR(100))
```

3. **SQL Query**: Inside the procedure, it executes a `SELECT` query to fetch the properties owned by the user with the given email. The query joins the `property`, `property_type`, and `property_owner` tables on their respective keys. It selects the `property_id`, `pType_id`, `pType_Desc`, `city`, `user_id`, `user_name`, and `user_email` fields. The `WHERE` clause filters the records where the `user_email` matches the input `user_email_value`.

```sql
BEGIN
    SELECT
        p.property_id,
        pt.pType_id,
        pt.pType_Desc,
        p.city,
        po.user_id,
        po.user_name,
        po.user_email
    FROM
        property p
    JOIN property_type pt ON p.pType_id = pt.pType_id
    JOIN property_owner po ON p.user_id = po.user_id
    WHERE
        po.user_email = user_email_value;
END //
```

4. **Call Procedure**: After creating the procedure, the script calls it with a sample email `"tkinningleyb@nasa.gov"` to fetch the properties owned by the user with this email.

```sql
CALL GetPropertiesByUserEmail("tkinningleyb@nasa.gov");
```

5. **Drop Procedure**: Finally, the script drops the procedure `GetPropertiesByUserEmail` after it has been executed.

```sql
DROP PROCEDURE IF EXISTS GetPropertiesByUserEmail;
```

This script is useful to fetch all properties owned by a specific user using their email address. The properties are returned along with their types.

## USE_CASE_7:
### Script: [use_case_7.sql](use_cases/use_case_7.sql)
This SQL script involves fetching all properties of a given property type along with the property owner details from the `property`, `property_type`, and `property_owner` tables.

1. **SQL Query**: The script executes a `SELECT` query to fetch all properties of a given property type along with the property owner details. The query joins the `property`, `property_type`, and `property_owner` tables on their respective keys. It selects the `property_id`, `pType_id`, `pType_Desc`, `city`, `user_id`, `user_name`, and `user_email` fields. The `WHERE` clause filters the records where the `pType_Desc` matches "Terrace Double".

```sql
SELECT
    p.property_id,
    pt.pType_id,
    pt.pType_Desc,
    p.city,
    po.user_id,
    po.user_name,
    po.user_email
FROM
    property p
JOIN property_type pt ON p.pType_id = pt.pType_id
JOIN property_owner po ON p.user_id = po.user_id
WHERE
    pt.pType_Desc = "Terrace Double";
```

This script is useful to fetch all properties of a given property type along with the property owner details from the `property`, `property_type`, and `property_owner` tables.
