```markdown
# COS20031 - CTDP Project

This document outlines the SQL queries used in the CTDP project.

## Table of Contents

1. [Complaint Resolution Duration](#complaint-resolution-duration)
2. [Property Type Count](#property-type-count)
3. [User Authentication](#user-authentication)
4. [Properties Owned by Specific User](#properties-owned-by-specific-user)
5. [Open Cases for Specific Property Type](#open-cases-for-specific-property-type)
6. [Properties Under Development](#properties-under-development)
7. [Users Owning More Than One Property](#users-owning-more-than-one-property)
8. [Properties with Floorplan Defects](#properties-with-floorplan-defects)
9. [Staff Members with No Closed Cases](#staff-members-with-no-closed-cases)
10. [User with Most Open Cases](#user-with-most-open-cases)
11. [Average Number of Properties per User](#average-number-of-properties-per-user)
12. [Properties of Specific Owner](#properties-of-specific-owner)

## Complaint Resolution Duration

To calculate the duration between the time of complaint and resolution, we use the `date_opened` and `date_closed` fields.

## Property Type Count

We count the number of each property type to decide how many property types exist.

## User Authentication

We authenticate users with the following SQL query:

```sql
SELECT * FROM property_owner WHERE user_email = 'johndoe@example.com' AND user_password = 'password123';
```

## Properties Owned by Specific User

To find all properties (including type description) owned by a user with a specific email address, we use the following SQL query:

```sql
SELECT p.property_id, p.type, pt.pType_Desc
FROM property p
INNER JOIN property_owner po ON p.user_id = po.user_id
INNER JOIN property_type pt ON p.pType_id = pt.pType_id
WHERE po.user_email = 'user@email.com';
```

## Open Cases for Specific Property Type

To list all open cases (date_closed is NULL) for properties of a specific type (e.g., 'Apartment') along with the owner's name, we use the following SQL query:

```sql
SELECT c.case_ref_id, p.type, po.user_name
FROM cases c
INNER JOIN property p ON c.property_id = p.property_id
INNER JOIN property_owner po ON p.user_id = po.user_id
WHERE p.type = 'Apartment' AND c.date_closed IS NULL;
```

## Properties Under Development

To find the total number of properties under development (development_status = 1) for each property type, we use the following SQL query:

```sql
SELECT pt.pType_Desc, COUNT(*) AS total_under_development
FROM property p
INNER JOIN property_type pt ON p.pType_id = pt.pType_id
WHERE p.development_status = 1
GROUP BY pt.pType_Desc;
```

## Users Owning More Than One Property

To list all users who own more than one property (including property count), we use the following SQL query:

```sql
SELECT po.user_id, po.user_name, COUNT(*) AS property_count
FROM property_owner po
INNER JOIN property p ON po.user_id = p.user_id
GROUP BY po.user_id
HAVING property_count > 1;
```

## Properties with Floorplan Defects

To find properties with floorplan defects reported in cases, excluding those resolved (date_closed is not NULL), we use the following SQL query:

```sql
SELECT p.property_id, p.type
FROM property p
INNER JOIN cases c ON p.property_id = c.property_id
WHERE c.floorplan_defect IS NOT NULL AND c.date_closed IS NULL;
```

## Staff Members with No Closed Cases

To identify staff members who haven't closed any cases yet (date_closed is NULL for all their cases), we use the following SQL query:

```sql
SELECT staff_id
FROM staff s
LEFT JOIN cases c ON s.staff_id = c.staff_id
GROUP BY staff_id
HAVING COUNT(c.case_ref_id) > 0 AND SUM(CASE WHEN c.date_closed IS NULL THEN 1 ELSE 0 END) = COUNT(c.case_ref_id);
```

## User with Most Open Cases

To find the user with the most open cases (date_closed is NULL), we use the following SQL query:

```sql
SELECT po.user_name, COUNT(*) AS open_cases
FROM property_owner po
INNER JOIN cases c ON po.user_id = c.user_id
WHERE c.date_closed IS NULL
GROUP BY po.user_id
ORDER BY open_cases DESC
LIMIT 1;
```

## Average Number of Properties per User

To find the average number of properties owned per user, we use the following SQL query:

```sql
SELECT AVG(property_count) AS avg_properties_per_user
FROM (
  SELECT po.user_id, COUNT(*) AS property_count
  FROM property_owner po
  INNER JOIN property p ON po.user_id = p.user_id
  GROUP BY po.user_id
) AS user_properties;
```

## Properties of Specific Owner

To list all properties of a specific owner (using user_id) with their development status, we use the following SQL query:

```sql
SELECT p.property_id, p.type, 
  CASE WHEN p.development_status = 0 THEN 'Not Under Development'
       WHEN p.development_status = 1 THEN 'Under Development'
  END AS development_status
FROM property p
WHERE p.user_id = 1001;
```
```
