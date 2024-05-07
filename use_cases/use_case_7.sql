-- Use Case 7: Given a property type, list all properties of that type along with the property owner details
-- Sample property type: "Terrace Double" 
-- Sample output: '10', '5', 'Terrace Double', 'Bintulu', '3', 'Penrod Jumel', 'pjumel2@amazon.de' (1st row)

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