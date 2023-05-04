-- CREATE VIEW suspected_rides AS
-- SELECT * FROM vehicle_location_histories AS vlh
-- WHERE
--     city = 'new york' AND
--     long BETWEEN 40.5 AND 40.6 AND
--     lat BETWEEN -74.997 AND -74.9968 AND
--     vlh.timestamp::DATE = '2020-06-23'::DATE
-- ORDER BY long;

-- SELECT DISTINCT r.vehicle_id, u.name AS "owner name", u.address, v.status, v.current_location
-- FROM suspected_rides AS sr
-- JOIN rides AS r ON r.id = sr.ride_id
-- JOIN vehicles AS v ON v.id = r.vehicle_id
-- JOIN users AS u ON u.id = v.owner_id;

-- SELECT DISTINCT r.vehicle_id, u.name AS "rider name", u.address
-- FROM suspected_rides AS sr
-- JOIN rides AS r ON r.id = sr.ride_id
-- JOIN users AS u ON u.id = r.rider_id;

-- CREATE VIEW suspect_rider_nemas AS
--     SELECT DISTINCT
--         SPLIT_PART(u.name, ' ', 1) AS "first_name",
--         SPLIT_PART(u.name, ' ', 2) AS "last_name"
--     FROM suspected_rides AS vlh
--     JOIN rides AS r ON r.id = vlh.ride_id
--     JOIN users AS u ON u.id = r.rider_id;

-- SELECT * FROM suspect_rider_nemas;

SELECT DISTINCT
    CONCAT(t1.first_name, ' ', t1.last_name) AS "employee",
    CONCAT(u.first_name, ' ', u.last_name) AS "rider"
    
FROM DBLINK('host=localhost user=postgres password=postgres dbname=Movr_Employees',
'SELECT first_name, last_name FROM employees;')
AS t1(first_name NAME, last_name NAME)

JOIN suspect_rider_nemas AS u ON t1.last_name = u.last_name
ORDER BY "rider";

-- MYSTERY SOLVED --
