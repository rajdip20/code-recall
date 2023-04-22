/* HOW MANY TOWNS ARE THERE IN FRANCE? */
-- SELECT COUNT(code) FROM towns;

/* COUNT THE NUMBER OF TOWNS PER REGION */
-- SELECT DISTINCT a.id, a."name", COUNT(c.id)
-- OVER (
--     PARTITION BY a.id
--     ORDER BY a."name"
-- ) AS "# of towns"
-- FROM regions AS a
-- JOIN departments AS b ON a.code = b.region 
-- JOIN towns AS c ON b.code = c.department
-- ORDER BY a.id;
