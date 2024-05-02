-- Use Case 4: Based on date_closed from cases table, list all cases for properties of a propety_type along with the oiwner's name and email
-- Sample to use: date_closed = NULL
-- Sample output: case_ref_id, user_id, user_name, user_email, staff_id, staff_name, property_id, pType_Desc, case_Desc, staff_comment, date_opened, date_closed

DROP PROCEDURE IF EXISTS GetCasesByDateClosed; -- Drop the procedure after useq

DELIMITER //
CREATE PROCEDURE GetCasesByDateClosed(IN date_closed_value DATE)
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
DELIMITER ;

CALL GetCasesByDateClosed(NULL);

DROP PROCEDURE IF EXISTS GetCasesByDateClosed;