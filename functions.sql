-- -------------- --

-- User Functions --

-- -------------- --

-- Function 1: Get Movie Info --
SELECT title, release_date, gross_revenue, genre, award_show, award_name, award_year, company_name, PERSON.name
FROM MOVIE, AWARD, MOVIE_GENRE, PRODUCTION_COMPANY, PERSON
WHERE @id = MOVIE.movie_id = MOVIE_GENRE.movie_id = MOVIE.movie_id = PRODUCTION_COMPANY.movie_id
	AND (person_id IN (SELECT person_id
                  		FROM INVOLVED_WITH
                  		WHERE movie_id = @id))
ORDER BY genre, award_show, company_name, PERSON.name;

-- Function 2: Search Movie --
SELECT title, COUNT(title) AS "Number of Results"
FROM MOVIE, PRODUCTION_COMPANY
WHERE MOVIE.title LIKE @title
OR MOVIE.release_date LIKE @date
OR PRODUCTION_COMPANY.company_name LIKE @company
OR (MOVIE.movie_id IN (SELECT movie_id
                 		FROM INVOLVED_WITH, PERSON
                 		WHERE PERSON.name LIKE @personName
                 		AND PERSON.person_id = INVOLVED_WITH.person_id))
GROUP BY title;

-- Function 3: Create User List --
INSERT INTO ACCOUNT_LIST
	VALUES(@listNum, @name, @description, CURDATE(), NULL);
INSERT INTO CURATES
	VALUES(@username, @listNum);

-- Function 4: Add To List --
INSERT IGNORE INTO IN_LIST
	VALUES ((SELECT ACCOUNT_LIST.list_id FROM ACCOUNT_LIST, ACCOUNT, CURATES WHERE ACCOUNT.username = @username AND CURATES.username = @username AND CURATES.list_id = ACCOUNT_LIST.list_id AND ACCOUNT_LIST.name = @listName), (SELECT movie_id FROM MOVIE WHERE title = @movie), @movie);
UPDATE ACCOUNT_LIST, CURATES, ACCOUNT
	SET last_updated = CURDATE()
    WHERE (SELECT ACCOUNT_LIST.list_id FROM ACCOUNT_LIST, ACCOUNT, CURATES WHERE ACCOUNT.username = @username AND CURATES.username = @username AND CURATES.list_id = ACCOUNT_LIST.list_id AND ACCOUNT_LIST.name = @listName) = ACCOUNT_LIST.list_id;
	

-- Function 5: Add Movie Rating --
INSERT INTO REVIEWS
	VALUES(@user, @movie_id, @stars, @review);

-- Function 6: Remove from List --
DELETE FROM IN_LIST
WHERE IN_LIST.movie_id = (SELECT movie_id
							FROM CURATES, IN_LIST
							WHERE CURATES.list_id=IN_LIST.list_id
							AND username=@username
							AND movie_id=@movie_id
							AND CURATES.list_id=@list_id);


-- Function 7: Get Reviews By User --
SELECT title AS "Movie Title", review_text AS "Review", num_stars AS "Star Rating"
FROM REVIEWS
INNER JOIN MOVIE ON MOVIE.movie_id = REVIEWS.movie_id
WHERE username = @user;

-- Function 8: Create User --
INSERT IGNORE INTO ACCOUNT
	VALUES(@user, @password);

-- Find all movies person is involved with --
SELECT title FROM MOVIE
WHERE movie_id IN (SELECT movie_id FROM INVOLVED_WITH
                   WHERE INVOLVED_WITH.movie_id = MOVIE.movie_id
                   AND person_id IN (SELECT person_id FROM PERSON
                                     WHERE name = @personName));


-- Function 9: Login --
SELECT username AS "Account"
FROM ACCOUNT
WHERE username = @username AND password = @password;

-- Function 10: Delete List --
DELETE FROM IN_LIST WHERE list_id = @id;
DELETE FROM CURATES WHERE list_id = @id;
DELETE FROM ACCOUNT_LIST WHERE list_id = @id;

-- Function 11: Delete Review --
DELETE FROM REVIEWS WHERE username = @user AND movie_id = @id;

-- Function 12: Modify List --
UPDATE ACCOUNT_LIST
SET name = @new_name, description = @new_description, last_updated = CURDATE();

-- ----------------------- --

-- Administrator Functions --

-- ----------------------- --

-- Function 1: Insert Movie --
INSERT INTO MOVIE
	VALUES(@movie_id, @title, @data, @revenue);
INSERT INTO MOVIE_GENRE
	VALUES(@id, @genre);
INSERT INTO PRODUCTION_COMPANY
	VALUES(@id, @company_name, @company_description);
INSERT IGNORE INTO PERSON
	VALUES(@person_id, @person_name, @gender, @person_description);
--INSERT IGNORE INTO DIRECTOR (or other role)
--	VALUES(@person_id);
INSERT INTO INVOLVED_WITH
	VALUES(@movie_id, @person_id, @position, @description);
INSERT INTO AWARD
	VALUES(@movie_id, @award_show, @award_name, @award_year);

-- Function 2: Delete Movie --
DELETE FROM IN_LIST WHERE movie_id = @movie_id;
DELETE FROM REVIEWS WHERE movie_id = @movie_id;
DELETE FROM INVOLVED_WITH WHERE movie_id = @movie_id;
DELETE FROM AWARD WHERE movie_id = @movie_id;
DELETE FROM MOVIE_GENRE WHERE movie_id = @movie_id;
DELETE FROM PRODUCTION_COMPANY WHERE movie_id = @movie_id;
DELETE FROM MOVIE WHERE movie_id = @movie_id;

-- Function 3: Modify Movie --
UPDATE MOVIE
SET title = @new_title, release_date = @new_release_date, gross_revenue = @new_gross_revenue
WHERE movie_id = @movie_to_change;
UPDATE IN_LIST, MOVIE
SET movie_title = MOVIE.title
WHERE @movie_to_change = IN_LIST.movie_id = MOVIE.movie_id;

-- Function 4: Delete user account --

-- Function 5: Add Person --
INSERT INTO PERSON
	VALUES(@person_id, @name, @gender, @biography);

-- Function 6: Delete Person --
DELETE FROM INVOLVED_WITH WHERE person_id = @id;
DELETE FROM SCREENWRITER WHERE person_id = @id;
DELETE FROM ACTOR WHERE person_id = @id;
DELETE FROM DIRECTOR WHERE person_id = @id;
DELETE FROM FILM_CREW WHERE person_id = @id;
DELETE FROM EXEC_PRODUCER WHERE person_id = @id;
DELETE FROm PRODUCER WHERE person_id = @id;
DELETE FROM PERSON WHERE person_id = @id;

-- Function 7: Modify Person -- 

-- Function 8: Insert Person Into Movie --




