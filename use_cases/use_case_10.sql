-- Use Case 10: Lists all staff (staff_id) who have unresolved cases (date_closed is NULL) with the number of unresolved cases and the total number of cases they have handled (date_closed is not NULL)

SELECT
    c.staff_id,
    s.staff_name,
    s.staff_phone,
    s.staff_email,
    COUNT(
        CASE
            WHEN c.date_closed IS NULL THEN 1
        END
    ) AS unresolved,
    COUNT(
        CASE
            WHEN c.date_closed IS NOT NULL THEN 1
        END
    ) AS resolved,
    COUNT(*) AS total_cases
FROM cases c
    INNER JOIN internal_staff s ON c.staff_id = s.staff_id
GROUP BY
    c.staff_id,
    s.staff_name,
    s.staff_phone,
    s.staff_email;