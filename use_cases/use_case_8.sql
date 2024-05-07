-- Use Case 8: List all open cases (date_closed is null) along with the property details and the property owner's user id and username
-- Sample output: 


SELECT
    c.case_id,
    c.user_id,
    c.property_id,
    c.date_opened,
    c.date_closed,
    p.city,
    p.property_id,
    p.pType_id,
    p.city,
    po.user_id,
    po.user_name