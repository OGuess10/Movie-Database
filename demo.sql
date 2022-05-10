-- Function 8: Create User --
INSERT IGNORE INTO ACCOUNT
	VALUES("user", "password");

-- Function 3: Create User List --
INSERT INTO ACCOUNT_LIST
	VALUES("1", "Favorites", "This is a list of my all time favorite movies.", CURDATE(), NULL);
INSERT INTO CURATES
	VALUES("user", "1");

-- Function 4: Add To List --
INSERT IGNORE INTO IN_LIST
	VALUES ((SELECT ACCOUNT_LIST.list_id FROM ACCOUNT_LIST, ACCOUNT, CURATES WHERE ACCOUNT.username = "user" AND CURATES.username = "user" AND CURATES.list_id = ACCOUNT_LIST.list_id AND ACCOUNT_LIST.name = "Favorites"), (SELECT movie_id FROM MOVIE WHERE title = "La La Land"), "La La Land");

-- Function 2: Search Movie --
SELECT title, COUNT(title) AS "Number of Results"
FROM MOVIE, PRODUCTION_COMPANY
WHERE MOVIE.title LIKE "Clue"
OR MOVIE.release_date LIKE "2018-05-07"
OR PRODUCTION_COMPANY.company_name LIKE "Productions"
OR (MOVIE.movie_id IN (SELECT movie_id
                 		FROM INVOLVED_WITH, PERSON
                 		WHERE PERSON.name LIKE "Emma Stone" 
                 		AND PERSON.person_id = INVOLVED_WITH.person_id))
GROUP BY title;

-- Find all movies person is involved with --
SELECT title FROM MOVIE
WHERE movie_id IN (SELECT movie_id FROM INVOLVED_WITH
                   WHERE INVOLVED_WITH.movie_id = MOVIE.movie_id
                   AND person_id IN (SELECT person_id FROM PERSON
                                     WHERE name = "Emma Stone"));