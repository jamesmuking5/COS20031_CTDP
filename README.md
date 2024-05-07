# **Explanation:**

## USE_CASE_1:

This SQL script involves fetching the duration of the latest case for a given user id and property id, if available and the case is closed.

Here's a step-by-step explanation:

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

This SQL script is creating a stored procedure named `GetPropertiesByCity` that takes a city name as an input and returns a list of properties in that city along with their property type and the user id of the property owner.

Here's a breakdown of the script:

1. `DROP PROCEDURE IF EXISTS GetPropertiesByCity;` - This line checks if a procedure named `GetPropertiesByCity` already exists in the database. If it does, it drops (deletes) it.

2. `DELIMITER //` - This line changes the delimiter from the default semicolon (`;`) to double slashes (`//`). This is done because the stored procedure contains semicolons, and we don't want MySQL to think those are the end of the statement.

3. `CREATE PROCEDURE GetPropertiesByCity(IN city_name VARCHAR(16))` - This line creates a new stored procedure named `GetPropertiesByCity`. It takes one input parameter, `city_name`, which is a string of up to 16 characters.

4. The `BEGIN ... END` block contains the SQL that will be run when the stored procedure is called. It's a `SELECT` statement that joins the `property`, `property_type`, and `property_owner` tables and filters for properties in the input city.

5. `FROM property p JOIN property_type pt ON p.pType_id = pt.pType_id JOIN property_owner po ON p.user_id = po.user_id` - These lines join the `property` table (aliased as `p`), `property_type` table (aliased as `pt`), and `property_owner` table (aliased as `po`) based on the `pType_id` and `user_id`.

6. `WHERE p.city = city_name;` - This line filters the results to only include properties where the city matches the input `city_name`.

7. `END //` - This line marks the end of the stored procedure.

8. `DELIMITER ;` - This line changes the delimiter back to the default semicolon (`;`).

9. `CALL GetPropertiesByCity('Kuching');` - This line calls the stored procedure with 'Kuching' as the input city.

10. `DROP PROCEDURE IF EXISTS GetPropertiesByCity;` - This line drops the procedure after it has been used. This is not typically done in production environments, but might be useful for testing or temporary procedures.

## USE_CASE_3:

This SQL script is creating a stored procedure named `GetPropertiesByEmail` that takes an email address as an input and returns a list of properties associated with that email, along with their property type and the user details.

Here's a breakdown of the script:

1. `DROP PROCEDURE IF EXISTS GetPropertiesByEmail;` - This line checks if a procedure named `GetPropertiesByEmail` already exists in the database. If it does, it drops (deletes) it.

2. `DELIMITER //` - This line changes the delimiter from the default semicolon (`;`) to double slashes (`//`). This is done because the stored procedure contains semicolons, and we don't want MySQL to think those are the end of the statement.

3. `CREATE PROCEDURE GetPropertiesByEmail(IN email_address VARCHAR(64))` - This line creates a new stored procedure named `GetPropertiesByEmail`. It takes one input parameter, `email_address`, which is a string of up to 64 characters.

4. The `BEGIN ... END` block contains the SQL that will be run when the stored procedure is called. It's a `SELECT` statement that joins the `property`, `property_type`, and `property_owner` tables and filters for properties where the owner's email matches the input `email_address`.

5. `FROM property p JOIN property_type pt ON p.pType_id = pt.pType_id JOIN property_owner po ON p.user_id = po.user_id` - These lines join the `property` table (aliased as `p`), `property_type` table (aliased as `pt`), and `property_owner` table (aliased as `po`) based on the `pType_id` and `user_id`.

6. `WHERE po.user_email = email_address;` - This line filters the results to only include properties where the owner's email matches the input `email_address`.

7. `END //` - This line marks the end of the stored procedure.

8. `DELIMITER ;` - This line changes the delimiter back to the default semicolon (`;`).

9. `CALL GetPropertiesByEmail('citzcovich8@weebly.com');` - This line calls the stored procedure with 'citzcovich8@weebly.com' as the input email.

10. `DROP PROCEDURE IF EXISTS GetPropertiesByEmail;` - This line drops the procedure after it has been used. This is not typically done in production environments, but might be useful for testing or temporary procedures.

## USE_CASE_4:

This SQL script is creating a stored procedure named `GetCasesByDateClosed` that takes a date as an input and returns a list of cases that were closed on that date. The cases are associated with properties of a certain type and the owner's name and email are also returned.

Here's a breakdown of the script:

1. `DROP PROCEDURE IF EXISTS GetCasesByDateClosed;` - This line checks if a procedure named `GetCasesByDateClosed` already exists in the database. If it does, it drops (deletes) it.

2. `DELIMITER //` - This line changes the delimiter from the default semicolon (`;`) to double slashes (`//`). This is done because the stored procedure contains semicolons, and we don't want MySQL to think those are the end of the statement.

3. `CREATE PROCEDURE GetCasesByDateClosed(IN date_closed_value DATE)` - This line creates a new stored procedure named `GetCasesByDateClosed`. It takes one input parameter, `date_closed_value`, which is a date.

4. The `BEGIN ... END` block contains the SQL that will be run when the stored procedure is called. It's a `SELECT` statement that joins the `cases`, `property`, `property_type`, `property_owner`, and `internal_staff` tables and filters for cases where the `date_closed` matches the input `date_closed_value` or both are `NULL`.

5. `FROM cases c JOIN property p ON c.property_id = p.property_id JOIN property_type pt ON p.pType_id = pt.pType_id JOIN property_owner po ON c.user_id = po.user_id JOIN internal_staff s ON c.staff_id = s.staff_id` - These lines join the `cases` table (aliased as `c`), `property` table (aliased as `p`), `property_type` table (aliased as `pt`), `property_owner` table (aliased as `po`), and `internal_staff` table (aliased as `s`) based on the `property_id`, `pType_id`, `user_id`, and `staff_id`.

6. `WHERE (c.date_closed = date_closed_value OR (date_closed_value IS NULL AND c.date_closed IS NULL));` - This line filters the results to only include cases where the `date_closed` matches the input `date_closed_value` or both are `NULL`.

7. `END //` - This line marks the end of the stored procedure.

8. `DELIMITER ;` - This line changes the delimiter back to the default semicolon (`;`).

9. `CALL GetCasesByDateClosed(NULL);` - This line calls the stored procedure with `NULL` as the input date.

10. `DROP PROCEDURE IF EXISTS GetCasesByDateClosed;` - This line drops the procedure after it has been used. This is not typically done in production environments, but might be useful for testing or temporary procedures.

## USE_CASE_5:

Use Case 5 is about user authentication using Python's `mysql-connector` to connect to a MySQL database. The script checks if a user exists in the database and whether the provided password is correct.

Here's a step-by-step explanation:

1. The script first establishes a connection to the MySQL database using `mysql.connector.connect()`. The connection parameters (host, user, password, and database) are provided.

2. It checks if the connection is successful using `cnx.is_connected()`. If the connection is successful, it prints "Connection to database successful."

3. It defines a function `authenticate_user(cnx, username, password)` that takes a database connection, a username, and a password as arguments.

4. Inside the function, it creates a cursor from the connection using `cnx.cursor()`.

5. It then executes a SQL query to select a user from the `property_owner` table where the username matches the provided username.

6. If the user does not exist (i.e., `cursor.fetchone()` returns `None`), it prints "User not found." If the user exists, it executes another SQL query to select the user where the username and password match the provided username and password.

7. If the password is incorrect (i.e., `cursor.fetchone()` returns `None`), it prints "User exists but password is incorrect". If the password is correct, it prints "User exists and password is correct".

8. The function is then called four times with different combinations of correct and incorrect usernames and passwords to demonstrate different outcomes.

9. For security purposes, if the password is correct and the username is wrong, the script will also return "No users found".

10.  Finally, the script closes the database connection using `cnx.close()`.

## USE_CASE_6:

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

## USE_CASE_7
This SQL query is designed to retrieve a list of properties of a specific type, along with the details of their respective owners. 

Here's how it works:

1. `SELECT`: This keyword is used to specify the data we want to retrieve from the database. In this case, we're retrieving the property ID, property type ID, property type description, city, user ID, user name, and user email.

2. `FROM property p`: This specifies the main table we're retrieving data from, which is the `property` table. The `p` is an alias for `property`, making the rest of the query easier to read and write.

3. `JOIN property_type pt ON p.pType_id = pt.pType_id`: This is a JOIN operation, which combines rows from two or more tables based on a related column. Here, we're joining the `property` table with the `property_type` table based on the `pType_id` column.

4. `JOIN property_owner po ON p.user_id = po.user_id`: This is another JOIN operation, this time joining the `property` table with the `property_owner` table based on the `user_id` column.

5. `WHERE pt.pType_Desc = "Terrace Double"`: This is a WHERE clause, which is used to filter records. This clause filters out all records where the property type description is not "Terrace Double".

So, in summary, this query retrieves all properties of type "Terrace Double", along with their respective owner details.

