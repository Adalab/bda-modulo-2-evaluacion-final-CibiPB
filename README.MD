## EVALUATION MODULE 2 - ADALAB


#### Presenter: Cibele Busnello
#### Date:      2025 March 12

#### My SQL Data Base: Sakila


These exercises consist in sorting data from different tables inside a data base. 

- During the exercises, you can se the use of a variety of functiong combined with the use of groups, for example:

    SELECT rating, ROUND(AVG(length),0) AS 'length_average' 
	    FROM film 
        GROUP BY rating;

     -- ROUND(AVG(),0) is aggregated to the GROUP BY, where the average is being reflected in the GROUP BY.

- Selecting by exclusion and comparisson, for example:
    SELECT title
	    FROM film
        WHERE rating NOT IN('PG-13','R');
    
    -- NOT IN is being used as exclusion of multiple values

    SELECT a.first_name, a.last_name
	    FROM film_actor as fa
	    INNER JOIN film AS f
	        ON fa.film_id = f.film_id
            INNER JOIN actor AS a
                    ON fa.actor_id = a.actor_id
                    WHERE f.title = 'Indian Love';

    -- This query includes a comparisson of columns and values WHERE column = 'given_value', returning only matches

- Use of JOIN's to aggregate multiple tables, for example: 

    SELECT r.customer_id, c.first_name, c.last_name,  COUNT(r.inventory_id) AS 'total_rented'
        FROM rental AS r
	    INNER JOIN customer as c
        ON r.customer_id = c.customer_id
        GROUP BY r.customer_id;

    -- INNER JOIN is merging columns based by the connections created by columns and it's matching values

- Presence of subconsultations as flow facilitator, for example:

    SELECT f.title -- , f.length, f.film_id, c.category_id, c.name : can be added for verification
    FROM film as f
    INNER JOIN film_category as fc
    ON f.film_id = fc.film_id
        INNER JOIN category as c
            ON c.category_id = fc.category_id
            WHERE f.length > 180 AND fc.category_id IN (SELECT c.category_id
                                                        FROM category AS c
                                                        WHERE c.name = 'comedy');

    -- IN works as connector the values of a table with the result of a different sorting in the subconsultation.