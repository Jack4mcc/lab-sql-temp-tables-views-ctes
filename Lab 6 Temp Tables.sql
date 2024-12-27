USE sakila;

CREATE VIEW customer_summary2 AS
SELECT email, COUNT(rental_id), customer_id
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY email;

SELECT *
FROM customer_summary2;

SELECT *
FROM rental;

SELECT *
FROM payment;

CREATE TEMPORARY TABLE amount_paid AS
SELECT email, SUM(amount) AS total_paid
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY email;

SELECT *
FROM amount_paid;

WITH combined_table AS (
SELECT email, SUM(amount) AS total_paid, last_name, email, amount
FROM amount_paid am)
INNER JOIN customer_summary2 c2
ON amm_customer_id = c2.customer_id;

