-- Use Case 8: Lists all property owners (users) that own (not rented) more than one property along with the count of properties they own.
-- Sample output: user_id, user_name, property_count

CREATE INDEX idx_ownership_user_id ON property (ownership_status, user_id);


SELECT po.user_id, po.user_name, COUNT(*) AS property_count
FROM property_owner po
    INNER JOIN property p ON po.user_id = p.user_id
WHERE
    p.ownership_status = 1
GROUP BY
    po.user_id
HAVING
    COUNT(*) > 1;

EXPLAIN SELECT po.user_id, po.user_name, COUNT(*) AS property_count
FROM property_owner po
    INNER JOIN property p ON po.user_id = p.user_id
WHERE
    p.ownership_status = 1
GROUP BY
    po.user_id
HAVING
    COUNT(*) > 1;

DROP INDEX idx_ownership_user_id ON property;