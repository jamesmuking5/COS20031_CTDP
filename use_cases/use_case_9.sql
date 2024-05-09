-- Use Case 9: Find properties with floorplan defects reported in cases, excluding those resolved (date_closed is not NULL)
-- sample output: case_ref_id, property_id, case_desc, user_id, staff_id, date_opened, staff_comment

SELECT c.case_ref_id, p.property_id, c.case_desc, c.user_id, c.staff_id, c.date_opened, c.staff_comment
FROM property p
    INNER JOIN cases c ON p.property_id = c.property_id
WHERE
    c.case_desc IN (
        'Wall defect',
        'Flooring issue',
        'Roofing issue',
        'Door issue',
        'Window issue'
    )
    AND c.staff_comment != 'Resolved'
    AND c.date_closed IS NULL;