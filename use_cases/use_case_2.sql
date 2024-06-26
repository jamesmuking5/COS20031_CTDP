-- Use Case 2: Based on the city from property table, create a list of properties in that city, get each property's property type from property_type table and user id from property_owner table
-- Sample to use: city = 'Kuching'
-- Sample output: property_id, property_name, property_type, user_id

CREATE INDEX idx_city ON property(city); -- Create an index on city column for faster query

DROP PROCEDURE IF EXISTS GetPropertiesByCity; -- Drop the procedure after use
DROP PROCEDURE IF EXISTS ExplainGetPropertiesByCity; -- Drop the procedure after use

DELIMITER //
CREATE PROCEDURE GetPropertiesByCity(IN city_name VARCHAR(16))
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

CREATE PROCEDURE ExplainGetPropertiesByCity(IN city_name VARCHAR(16))
BEGIN
    EXPLAIN SELECT
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


DELIMITER ;

CALL GetPropertiesByCity('Kuching'); -- Call the procedure
CALL ExplainGetPropertiesByCity('Kuching'); -- Call the procedure's explain
DROP PROCEDURE IF EXISTS GetPropertiesByCity; -- Drop the procedure after use
DROP INDEX idx_city ON property; -- Drop the index after use