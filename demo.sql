
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
                   WHERE person_id IN (SELECT person_id FROM PERSON
                                     WHERE name = "Emma Stone"));

-- ------------------------------------------------------------------- --

-- Function 1: Insert Movie --
INSERT INTO MOVIE
	VALUES("001", "La La Land", "2016-12-09", 448900000);
INSERT INTO MOVIE_GENRE
	VALUES("001", "Romance");
INSERT INTO MOVIE_GENRE
	VALUES("001", "Musical");
INSERT INTO PRODUCTION_COMPANY
	VALUES("001", "Summit Entertainment", "Summit Entertainment is an American film production and distribution company. It is a label of Lionsgate Films, owned by Lionsgate Entertainment and is headquartered in Santa Monica, California.");
INSERT IGNORE INTO PERSON
	VALUES("001", "Damien Chazelle", "Male", "Damien Sayre Chazelle is an American film director, producer, and screenwriter. He is known for his films Whiplash, La La Land, and First Man.");
INSERT IGNORE INTO DIRECTOR
	VALUES("001");
INSERT INTO INVOLVED_WITH
	VALUES("001", "01", "Director", "Chazelle directed La La Land.");
INSERT IGNORE INTO PERSON
	VALUES("002", "Fred Berger", "Male", "Fred Berger is an American film producer who was nominated for the Academy Award for Best Picture for the 2016 musical La La Land, for which he also won the 2016 Golden Globe Award for Best Motion Picture – Musical or Comedy and Producers Guild of America Award for Best Theatrical Motion Picture.");
INSERT IGNORE INTO PRODUCER
	VALUES("002");
INSERT INTO INVOLVED_WITH
	VALUES("001", "002", "Producer", "Fred Berger produced La La Land.");
INSERT IGNORE INTO PERSON
	VALUES("003", "Emma Stone", "Female", "Emily Jean \"Emma\" Stone is an American actress. She is the recipient of various accolades, including an Academy Award, a British Academy Film Award, and a Golden Globe Award. In 2017, she was the world's highest-paid actress and named by Time magazine as one of the 100 most influential people in the world.");
INSERT IGNORE INTO ACTOR
	VALUES("003");
INSERT INTO INVOLVED_WITH
	VALUES("001", "003", "Actress", "Stone was the leading actress in La La Land.");
INSERT INTO AWARD
	VALUES("001", "Oscars", "Academy Award for Best Actress", 2017);
INSERT INTO AWARD
	VALUES("001", "Oscars", "Academy Award for Best Music", 2017);
INSERT INTO AWARD
	VALUES("001", "Oscars", "Academy Award for Best Directing", 2017);
INSERT INTO AWARD
	VALUES("001", "Golden Globes", "Best Motion Picture", 2017);

 -- Function 8: Create User --
INSERT IGNORE INTO ACCOUNT
	VALUES("user", "password");

-- Function 3: Create User List --
INSERT INTO ACCOUNT_LIST
	VALUES("1", "Favorites", "This is a list of my all time favorite movies.", CURDATE(), NULL);
INSERT INTO CURATES
	VALUES("user", "1");

-- Function 2: Delete Movie --
DELETE FROM IN_LIST WHERE movie_id = "001";
DELETE FROM REVIEWS WHERE movie_id = "001";
DELETE FROM INVOLVED_WITH WHERE movie_id = "001";
DELETE FROM AWARD WHERE movie_id = "001";
DELETE FROM MOVIE_GENRE WHERE movie_id = "001";
DELETE FROM PRODUCTION_COMPANY WHERE movie_id = "001";
DELETE FROM MOVIE WHERE movie_id = "001";