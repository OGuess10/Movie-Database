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