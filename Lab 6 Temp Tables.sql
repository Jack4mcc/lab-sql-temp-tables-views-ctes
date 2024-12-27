USE sakila;


CREATE VIEW customer_summary3 AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(*) AS rental_count
FROM 
    customer AS c
    JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    rental_count DESC;
    
    SELECT *
    FROM customer_summary3;


SELECT *
FROM rental;

SELECT *
FROM payment;

CREATE TEMPORARY TABLE customer_payment_summary AS (
SELECT cs.customer_id, email, SUM(amount) AS total_paid
FROM customer_summary3 cs
INNER JOIN payment p
ON cs.customer_id = p.customer_id
GROUP BY cs.customer_id);


WITH customer_summary_report AS(
SELECT 
    cs.customer_name,
    cs.email,
    cs.rental_count,
    cs.total_paid
FROM 
    customer_summary3 AS cs
    JOIN customer_summary3 AS cps ON cs.customer_id = cps.customer_id)

SELECT 
    *,
    total_paid / rental_count AS average_payment_per_rental
FROM 
    customer_summary_report
ORDER BY 
    rental_count DESC;


