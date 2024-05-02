# **Explanation:**

## USE_CASE_1:

This SQL script creates a stored procedure named `GetCaseDuration` that calculates the duration of the latest case for a given user and property, if available and the case is closed.

Here's a step-by-step explanation:

1. `CREATE PROCEDURE GetCaseDuration() BEGIN ... END`: This creates a stored procedure named `GetCaseDuration`.

2. `DECLARE user_exists INT;`: This declares a variable named `user_exists` that will be used to check if the user exists in the `property_owner` table.

3. `SELECT COUNT(*) INTO user_exists FROM property_owner WHERE user_id = 299;`: This checks if a user with `user_id` 299 exists in the `property_owner` table. If the user exists, `user_exists` will be greater than 0.

4. `IF user_exists > 0 THEN ... ELSE ... END IF;`: This is a conditional statement that checks the value of `user_exists`. If `user_exists` is greater than 0, it means the user exists and the code inside the `THEN` block is executed. If `user_exists` is not greater than 0, it means the user does not exist and the code inside the `ELSE` block is executed.

5. Inside the `THEN` block, a `SELECT` statement is used to calculate the duration of the latest case for the user from the `cases` table. The `CASE` statement checks if `date_closed` is not null. If it's not null, it calculates the duration between `date_opened` and `date_closed` in months, weeks, days, hours, and minutes. If `date_closed` is null, it returns 'No closed date available'.

6. Inside the `ELSE` block, a `SELECT` statement is used to return a message saying 'User does not exist'.

7. `CALL GetCaseDuration();`: This calls the `GetCaseDuration` procedure.

8. `DROP PROCEDURE IF EXISTS GetCaseDuration;`: This deletes the `GetCaseDuration` procedure after it has been called. The `IF EXISTS` clause is used to prevent an error from occurring if the procedure does not exist.


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
