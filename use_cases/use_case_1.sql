-- Use Case 1: Given user id and property id, get the duration of the latest case if available and date_closed is not null
-- Sample to use: user_id = 299, property_id = 1090
-- Sample output: 7 months, 3 weeks, 5 days, 2 hours, 10 minutes

DELIMITER //
CREATE PROCEDURE GetCaseDuration()
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists
    FROM property_owner -- Check property_owner table
    WHERE user_id = 299;

    IF user_exists > 0 THEN
        SELECT
            user_id,
            property_id,
            CASE
                WHEN date_closed IS NOT NULL THEN
                    CONCAT(
                        FLOOR(DATEDIFF(date_closed, date_opened) / 30), ' months, ',
                        FLOOR(DATEDIFF(date_closed, date_opened) % 30 / 7), ' weeks, ',
                        FLOOR(DATEDIFF(date_closed, date_opened) % 7), ' days, ',
                        FLOOR(TIME_TO_SEC(TIMEDIFF(date_closed, date_opened)) % 24), ' hours, ',
                        FLOOR(TIME_TO_SEC(TIMEDIFF(date_closed, date_opened)) % 3600 / 60), ' minutes'
                    )
                ELSE
                    'No closed date available'
            END AS duration -- Calculate duration
        FROM 
            cases -- Check cases table
        WHERE 
            user_id = 299 AND property_id = 1090;
    ELSE
        SELECT 'User does not exist' AS message;
    END IF;
END //
DELIMITER ; 

CALL GetCaseDuration(); -- Call the procedure
DROP PROCEDURE IF EXISTS GetCaseDuration; -- Drop the procedure after use