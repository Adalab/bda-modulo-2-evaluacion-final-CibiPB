USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/

SELECT DISTINCT title
	FROM film;

/* 2.  Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/

SELECT title
	FROM film
	WHERE rating = "PG-13";

/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción. */

SELECT title, `description` -- Description is a reserved word, using ` is a way to read it as a column.
	FROM film
	WHERE `description` LIKE '%amazing%'; -- Used like since IN is more applicable to compare values
    
/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

SELECT title -- ,length: can be added for verification
	FROM film
    WHERE length > 120; -- The length is smallint type
    
/* 5. Recupera los nombres de todos los actores.*/

SELECT first_name, last_name
	FROM actor;
    
/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE '%Gibson%';

/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

SELECT first_name, last_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20; -- actod_id is smallint type
    
/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación.*/

SELECT title
	FROM film
    WHERE rating NOT IN('PG-13','R');
    
/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento.*/

SELECT rating, COUNT(rating) AS 'total_films'
	FROM film
    GROUP BY rating;
    
/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT r.customer_id, c.first_name, c.last_name,  COUNT(r.inventory_id) AS 'total_rented'
FROM rental AS r
	INNER JOIN customer as c
    ON r.customer_id = c.customer_id
    GROUP BY r.customer_id;

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres. HELP */

SELECT c.name AS 'category_name', COUNT(r.rental_id) AS 'rental_count'
	FROM rental AS r
	INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
		INNER JOIN film AS f 
        ON f.film_id = i.film_id
			INNER JOIN film_category AS fc 
            ON fc.film_id = f.film_id
				INNER JOIN category AS c 
                ON c.category_id = fc.category_id
GROUP BY c.category_id;

SELECT COUNT(r.inventory_id), f.name AS 'category_name'
	FROM rental AS r
	INNER JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
		INNER JOIN film AS f
        ON i.film_id = f.film_id
			GROUP BY f.category;
            
            SELECT f.`name` FROM category as f;
            
/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.*/

SELECT rating, ROUND(AVG(length),0) AS 'length_average' -- the lenght average is being rounded to not show after decimals
	FROM film 
    GROUP BY rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

SELECT a.first_name, a.last_name -- , f.title  for verification, either inner join or left join could be used here
	FROM film_actor as fa
	INNER JOIN film AS f
	ON fa.film_id = f.film_id
    INNER JOIN actor AS a
    ON fa.actor_id = a.actor_id
    WHERE f.title = 'Indian Love';
    
/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

SELECT title -- , `description` for verification
	FROM film
	WHERE `description` LIKE ('%DOG%') OR `description` LIKE '%CAT%';
    
/* 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.*/

SELECT f.actor_id, a.actor_id
	FROM film_actor AS f
	RIGHT JOIN actor AS a -- Right Join to ensure the actores are listed even thougth they are not in the film_actor table.
	ON f.actor_id = a.actor_id
	WHERE f.actor_id IS NULL; -- to list any unmatched with the actor list.

/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */


SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010; -- Includes 2005 and 2010, but in the data, all movies are from 2006

SELECT title, release_year -- confirmation
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

SELECT DISTINCT(f.title) -- add for verification: , c.`name` 
	FROM film AS f
	INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
		INNER JOIN category AS c
        ON fc.category_id = c.category_id
        WHERE c.`name` = ('Family'); 
    

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

SELECT  CONCAT(a.first_name,' ', a.last_name) AS 'actor_full_name'
	FROM actor as a
	INNER JOIN film_actor as f
	ON a.actor_id = f.actor_id
    GROUP BY actor_full_name -- Concat to combine the first and last names
    HAVING COUNT(film_id) > 10
    ORDER BY COUNT(film_id) ASC; -- added for clear results reading
    
/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/

SELECT title, length, rating
	FROM film
	WHERE length > 120 AND rating = "R"
	ORDER BY length ASC;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración. */ 

SELECT c.`name` AS category_name, ROUND(AVG(f.length),0) AS 'average_length'
FROM film_category AS fc
	INNER JOIN category AS c
        ON fc.category_id = c.category_id
        INNER JOIN film AS f
        ON f.film_id = fc.film_id
        GROUP BY category_name, c.category_id -- Grouping to by category to then sort by the length average of all the films on that category
        HAVING average_length > 120 ;
        
        /* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado. */

SELECT  CONCAT(a.first_name,' ', a.last_name) AS 'actor_full_name', COUNT(film_id) AS 'film_counter' -- Alias asigned to facilitate reading 
	FROM actor as a
	INNER JOIN film_actor as f
	ON a.actor_id = f.actor_id
    GROUP BY actor_full_name
    HAVING film_counter > 5
	ORDER BY film_counter ASC;
    
/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes. */

    
SELECT f.title, DATEDIFF(r.return_date, r.rental_date) AS 'rental_length' 
FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN (SELECT rental_id
						FROM rental
						WHERE DATEDIFF(return_date, rental_date) > 5);

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.*/


SELECT DISTINCT (CONCAT(a.first_name, ' ', a.last_name)) AS 'full_name' -- First I included all the actors independend od film category, by joining actors and films, then:
	FROM actor as a
	INNER JOIN film_actor as fa
    ON a.actor_id = fa.actor_id
		INNER JOIN film as f
        ON f.film_id = fa.film_id
		WHERE a.actor_id NOT IN (SELECT fa.actor_id -- : used NOT IN to exclude the Horror actors from final output
								FROM film_actor AS fa
								INNER JOIN film AS f
								ON fa.film_id = f.film_id
									INNER JOIN film_category AS fc
									ON f.film_id = fc.film_id
									INNER JOIN category AS c
									ON fc.category_id = c.category_id
									WHERE c.name = 'Horror');
/* for table reference: 
SELECT first_name, last_name, actor_id
FROM actor;

SELECT film_id, actor_id
FROM film_actor;

SELECT film_id
FROM film;

SELECT category_id, film_id
FROM film_category;

SELECT category_id, `name`
FROM category
WHERE c.`name` = 'horror';*/

/* 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/

SELECT f.title -- , f.length, f.film_id, c.category_id, c.name : can be added for verification
FROM film as f
	INNER JOIN film_category as fc
    ON f.film_id = fc.film_id
    INNER JOIN category as c
		ON c.category_id = fc.category_id
        WHERE f.length > 180 AND fc.category_id IN (SELECT c.category_id
													FROM category AS c
                                                    WHERE c.name = 'comedy');

