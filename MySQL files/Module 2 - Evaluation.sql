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

SELECT title, length 
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

SELECT first_name, last_name, actor_id
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20; -- actod_id is smallint type
    
/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación.*/

SELECT title
	FROM film
    WHERE rating NOT IN('PG-13','R');