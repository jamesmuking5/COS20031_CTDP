-- Use Case 3: based on the email address from property_owner table, get all properties including type description
-- Sample to use: email = 'citzcovich8@weebly.com'
-- Sample output: property_id, property_type, property_Desc , user_id, user_name, email

CREATE INDEX idx_email ON property_owner(user_email); -- Create an index on user_email column for faster query

DROP PROCEDURE IF EXISTS GetPropertiesByEmail; -- Drop the procedure after use
DROP PROCEDURE IF EXISTS ExplainGetPropertiesByEmail; -- Drop the procedure after use

DELIMITER //
CREATE PROCEDURE GetPropertiesByEmail(IN email_address VARCHAR(64))
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

CREATE PROCEDURE ExplainGetPropertiesByEmail(IN email_address VARCHAR(64))
BEGIN
    EXPLAIN SELECT
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
DELIMITER ;

CALL GetPropertiesByEmail('citzcovich8@weebly.com'); -- Call the procedure
CALL ExplainGetPropertiesByEmail('citzcovich8@weebly.com'); -- Call the procedure's explain
DROP PROCEDURE IF EXISTS GetPropertiesByEmail; -- Drop the procedure after use
DROP INDEX idx_email ON property_owner; -- Drop the index after use