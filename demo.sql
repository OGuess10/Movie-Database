-- --------------------- --

-- Database Demonstration --

-- --------------------- --

-- Function 3: Modify Movie --
UPDATE MOVIE
SET title = "Not La La Land"
WHERE movie_id = 1;
UPDATE IN_LIST, MOVIE
SET movie_title = MOVIE.title
WHERE 1 = IN_LIST.movie_id = MOVIE.movie_id;

-- ---------------------- --
--        Queries         --
-- ---------------------- --

-- Function 2: Search Movie --
SELECT title AS "Movie Title"
FROM MOVIE, PRODUCTION_COMPANY
WHERE MOVIE.title LIKE "Clue"
OR MOVIE.release_date LIKE "2018-05-07"
OR PRODUCTION_COMPANY.company_name LIKE "Productions"
OR (MOVIE.movie_id IN (SELECT movie_id
                 		FROM INVOLVED_WITH, PERSON
                 		WHERE PERSON.name LIKE "Emma Stone" 
                 		AND PERSON.person_id = INVOLVED_WITH.person_id))
GROUP BY title;

-- Function 13: Find all movies person is involved with --
SELECT title FROM MOVIE
WHERE movie_id IN (SELECT movie_id FROM INVOLVED_WITH
                   WHERE person_id IN (SELECT person_id FROM PERSON
                                     WHERE name = "Emma Stone"));

-- Function 7: Get Reviews By User --
SELECT title AS "Movie Title", review_text AS "Review", num_stars AS "Star Rating"
FROM REVIEWS
INNER JOIN MOVIE ON MOVIE.movie_id = REVIEWS.movie_id
WHERE username = "user";

-- Get Star Ratings
SELECT title AS "Movie Title", AVG(num_stars) AS "Average Star Rating"
FROM MOVIE, REVIEWS
WHERE MOVIE.movie_id = REVIEWS.movie_id
GROUP BY title
ORDER BY AVG(num_stars) DESC;
