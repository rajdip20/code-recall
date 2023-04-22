/* HOW MANY OFFICIAL LANGUAGES ARE THERE? */
-- SELECT COUNT('language') FROM countrylanguage;

/* WHAT IS THE AVERAGE LIFE EXPECTANCY IN THE WORLD? */
-- SELECT AVG(lifeexpectancy) FROM country;

/* WHAT IS THE AVERAGE POPULATION FOR CITIES IN THE NETHERLANDS? */
-- SELECT AVG(population) FROM city WHERE countrycode = 'NLD';

/* HOW MANY CITIES ARE IN THE DISTRICT OF ZUID-HOLLAND, NOORD-BRABANT AND UTRECHT? */
-- SELECT COUNT(id) FROM city WHERE district IN ('Zuid-Holland', 'Noord-Holland', 'Utrecht');

/* CAN I GET A LIST OF DISTINCT LIFE EXPECTANCY AGES, MAKE SURE THERE ARE NO NULLS */
-- SELECT DISTINCT lifeexpectancy FROM country WHERE lifeexpectancy IS NOT NULL ORDER BY lifeexpectancy;

/* SHOW THE POPULATION PER CONTINENT */
-- SELECT continent, SUM(population) AS "continent population"
-- FROM country
-- GROUP BY continent;
-- /* OR */
-- SELECT DISTINCT continent, SUM(population)
-- OVER w1 as "continent population"
-- FROM country
-- WINDOW w1 AS( PARTITION BY continent );

/* To the previous query add on the ability to calculate the percentage of the world population. What that means is that you will divide the population of that continent by the total population and multiply by 100 to get a percentage. Make sure you convert the population numbers to float using `population::float` otherwise you may see zero pop up Try to use CONCAT AND ROUND to make the data look pretty */
-- SELECT DISTINCT continent, SUM(population)
-- OVER w1 as "continent population",
-- CONCAT(
--     ROUND(
--         (
--             SUM(population::float4) OVER w1 / SUM(population::float4) OVER()
--         )*100),'%') as "percentage of population"
-- FROM country
-- WINDOW w1 AS(PARTITION BY continent);
