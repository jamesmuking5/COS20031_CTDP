-- Use Case 4: Given an input user_email, fetch all properties owned by the user along with the property type
-- Sample email: "tkinningleyb@nasa.gov"
-- Sample output: '42', '5', 'Terrace Double', 'Kuching', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'
-- '43', '4', 'Terrace Single', 'Miri', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'
-- '44', '8', 'Shop Lot', 'Miri', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'
-- '45', '5', 'Terrace Double', 'Kuching', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'
-- '46', '1', 'Bungalow', 'Bintulu', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'
-- '47', '8', 'Shop Lot', 'Kuching', '12', 'Tedmund Kinningley', 'tkinningleyb@nasa.gov'


DROP PROCEDURE IF EXISTS GetPropertiesByUserEmail;

DELIMITER //
CREATE PROCEDURE GetPropertiesByUserEmail(IN user_email_value VARCHAR(100))
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
DELIMITER ;

CALL GetPropertiesByUserEmail("tkinningleyb@nasa.gov");

DROP PROCEDURE IF EXISTS GetPropertiesByUserEmail;