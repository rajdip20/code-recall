/* HOW MANY FEMALE CUSTOMERS DO WE HAVE FROM THE STATE OF OREGON (OR) AND NEW YORK (NY) */
-- SELECT count(customerid) FROM customers WHERE gender='F' AND (state='OR' OR state='NY');

/* HOW MANY CUSTOMERS AREN'T 55? */
-- SELECT count(customerid) FROM customers WHERE NOT age=55;

/* WHO OVER THE AGE OF 44 HAS AN INCOME OF 100000 */
-- SELECT firstname, lastname FROM customers WHERE age>44 AND income=100000;

/* HOW MANY FEMALE CUSTOMERS DO WE HAVE FROM THE STATE OF OREGON (OR) */
-- SELECT COUNT(customerid) FROM customers WHERE state='OR' AND gender='F';

/* WHO BETWEEN THE AGES OF 30 AND 50 HAS AN INCOME LESS THAN 50000? (INCLUDING 30 AND 50) */
-- SELECT firstname, lastname FROM customers WHERE (age>=30 AND age<=50) AND income<50000
 
/* WHAT IS THE AVERAGE INCOME BETWEEN THE AGES OF 20 AND 50? (EXCLUDING 20 AND 50) */
-- SELECT AVG(income) FROM customers WHERE age>20 AND age<50;

/* SELECT PEOPLE EITHER UNDER 30 OR OVER 50 WITH AN INCOME ABOVE 50000, INCLUDE PEOPLE THAT ARE 50, THAT ARE FROM EITHER JAPAN OR AUSTRALIA*/
-- SELECT firstname, lastname, country, age, income FROM customers WHERE (age<30 OR age>=50) AND (country='Japan' OR country='Australia') AND income>50000;

/* WHAT WAS OUR TOTAL SALES IN JUNE OF 2004 FOR ORDERS OVER 100 DOLLARS? */
-- SELECT SUM(totalamount) FROM orders WHERE (orderdate>='2004-06-01' AND orderdate<='2004-06-30') AND totalamount>100;

/* ADJUST THE FOLLOWING QUERY TO DISPLAY THE NULL VALUES AS "No Address" */
-- SELECT COALESCE(address2, 'No Address') FROM customers;

/* FIX THE FOLLOWING QUERY TO APPLY PROPER 3VL */
-- SELECT * FROM customers WHERE address2 IS NOT null;

/* FIX THE FOLLOWING QUERY TO APPLY PROPER 3VL */
-- SELECT COALESCE(lastName, 'Empty'), * FROM customers WHERE (age IS null);

/* WHO BETWEEN THE AGES OF 30 AND 50 HAS AN INCOME LESS THAN 50000? (INCLUDE 30 AND 50 IN THE RESULTS) */
-- SELECT customerid, firstname, lastname, age, income FROM customers WHERE income<50000 AND age BETWEEN 30 AND 50; 

/* WHAT IS THE AVERAGE INCOME BETWEEN THE AGES OF 20 AND 50? (Including 20 AND 50) */
-- SELECT AVG(income) FROM customers WHERE age BETWEEN 20 AND 50;

/* HOW MANY ORDERS WERE MADE BY CUSTOMER 7888, 1082, 12808, 9623 */
-- SELECT COUNT(orderid) FROM orders WHERE customerid IN (7888, 1082, 12808, 9623);

/* HOW MANY PEOPLE'S ZIPCODE HAVE A 2 IN IT? */
-- SELECT COUNT(customerid) FROM customers WHERE zip::TEXT LIKE '%2%';

/* HOW MANY PEOPLE'S ZIPCODE START WITH 2 WITH THE 3RD CHARACTER BEING A 1 */
-- SELECT COUNT(customerid) FROM customers WHERE zip::TEXT LIKE '2_1%';

/* WHICH STATES HAVE PHONE NUMBERS STARTING WITH 302? REPLACE NULL VALUES WITH "No State" */
-- SELECT COALESCE(state, 'No State') AS state, phone  FROM customers WHERE phone::TEXT LIKE '302%';

/* HOW MANY ORDERS WERE MADE IN JANUARY 2004? */
-- SELECT COUNT(orderid) FROM orders WHERE EXTRACT(MONTH FROM orderdate)=1;

/* GET ALL ORDERS FROM CUSTOMERS WHO LIVE IN OHIO(OH), NEW YORK (NY) OR OREGON (OR) STATE */
-- SELECT b.firstname, b.lastname, a.orderid, b.state FROM orders AS a
-- INNER JOIN customers AS b ON a.customerid = b.customerid
-- WHERE b.state IN ('OH', 'NY', 'OR')
-- ORDER BY orderid;

/* SHOW ME THE INVENTORY FOR EACH PRODUCT */
-- SELECT a.prod_id, a.title, b.quan_in_stock FROM products AS a
-- INNER JOIN inventory AS b ON a.prod_id = b.prod_id;

/* CREATE A CASE STATEMENT THAT'S NAMED "PRICE CLASS" WHERE IF A PRODUCT IS OVER 20 DOLLARS YOU SHOW 'EXPENSIVE' IF IT'S BETWEEN 10 AND 20 YOU SHOW 'AVERAGE' AND IF IT'S LOWER THAN OR EQUAL TO 10 YOU SHOW 'CHEAP'. */
-- SELECT price,
--     (CASE
--         WHEN price > 20 THEN 'Expensive'
--         WHEN price BETWEEN 10 AND 20 THEN 'Average'
--         WHEN price <= 10 THEN 'Cheap'
--         END
--     ) AS "Price Class"
-- FROM products;

/* SHOW NULL WHEN THE PRODUCT IS NOT ON SPECIAL (0) */
-- SELECT prod_id, title, price, NULLIF(special, 0) AS "special" FROM products;

/* GET ALL ORDERS FROM CUSTOMERS WHO LIVE IN OHIO(OH), NEW YORK (NY) OR OREGON (OR) STATE ORDERED BY ORDERID */
-- SELECT b.firstname, b.lastname, a.orderid 
-- FROM orders AS a, (
--     SELECT customerid, state, firstname, lastname
--     FROM customers
-- ) AS b
-- WHERE  a.customerid = b.customerid AND 
-- b.state IN ('NY', 'OH', 'OR')
-- ORDER BY a.orderid;

