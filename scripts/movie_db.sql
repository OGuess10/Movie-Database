CREATE DATABASE MovieDatabase;
USE MovieDatabase;

CREATE TABLE USER(
    username VARCHAR(31) NOT NULL,
    password VARCHAR(31) NOT NULL,
    PRIMARY KEY(username)
);
CREATE TABLE LIST(
    list_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(2047),
    date_created DATE NOT NULL,
    last_updated DATE,
    PRIMARY KEY(list_id)
);
CREATE TABLE PERSON(
    person_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(255) NOT NULL,
    biography VARCHAR(2047),
    PRIMARY KEY(person_id)
);
CREATE TABLE MOVIE(
    movie_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    gross_revenue FLOAT,
    PRIMARY KEY(movie_id)
);
CREATE TABLE MOVIE_GENRE(
    movie_id INT NOT NULL,
    genre VARCHAR(255) NOT NULL,
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
    PRIMARY KEY(genre)
);

/*
Function1: Get_movie_info
Description: Get information about a movie: awards, production company, release date, genre, gross revenue, and all people involved. When viewing a movie, the user will be able to see the information associated with that movie.
Input: MOVIE.movie_id
Steps:
Find movie in “movie” table that matches the given movie_id
Display movie title, gross_revenue, genre, and release_date
Search for entities in “wins”, “produced”, and “involved_with” tables that match the movie_id.
Display the award_name, award_show, and year from the “wins” table.
Display the company_name from “produced” table.
Find entities in “person” table that match person_id from “involved with” table.
Display person name from “person” table with position from “involved_with” table.

Function 2: Search_movie
Description: Get a list of movies searched by title, production company, release date, and/or person. A user can search using this criteria and this will display a list of movies that are associated.
Input: MOVIE.title or MOVIE.release_date or PRODUCTION_COMP.company_name or PERSON.name
Steps:
Check which input(s) have been entered and if they exist in the database
Find the movie associated with each input and insert name and movie_id to the “search” table
Display the movie name’s from the “search” table to the user
When a user clicks on the movie’s name from the search, they are able to view the movie’s page (use the movie_id in search table to view all movie information: get_movie_info).

Function 3: create_user_list
Description: A user can create a list of movies
Input: name and description strings for LIST
Steps:
the user is asked to provide a list name and description
a list id is generated to be used to identify the list
A new LIST entity is added to the “lists” table with the following information: list_id, name, description, date created, and last updated (both dates will be the current date).
A new entity is added to CURATES, which includes the user.id and list.id
Display the empty list back to the user, including list name and description.

Function 4 : add_to_list
Description: A movie can be added to an already-defined user created list from the movie page
Input: list.name and movie.id
Steps:
A user selects the “add movie to list” button on the movie page
Using the current user’s username, find the list of list.ids from the “curates” table.
From that list of ids, find the matching list names in the “lists” table
Display to the user which list (using the list names) they’d like to add the movie to. The user then selects a list name
From the movie page, find the movie_id of the movie that is currently being displayed 
Add a new entity in the “in” table. 
The list name the user selected is referenced in the “lists” table, which includes the list id in the same entity. So this list.id is added to the new entity in the ”in” table.
The movie.id and movie.title from the currently displaying movie entity is also added to the entity.
Using the list.id, find the “list” entity and change list.last_updated to the current date.
Display to the user that the movie has been successfully added to the list.

Function 5: Add_movie_rating
Description: A user can submit a review containing the number of stars out of 5, as well as a written review.
Input: MOVIE.id, USER.username, stars (int from 0-5), and rating text
Steps:
User provide a star rating on a scale of 0-5 and review text on a given movie.
A new REVIEWS entity is added to the “reviews” table with the following information: the user’s username, the movie id, the movie title, the star rating (num_stars) and the review text.

Function 6: remove_from_list
Description: A user can remove a movie from a user created list
Input: USER.username, MOVIE.Title, MOVIE.id, LIST.id
Steps:
A user clicks on the remove button next to the movie name on the list view
In the “in” table, delete the entity that includes the currently viewed list.id, selected movie.id, and movie.title.
In the “list” table, the entity with matching list.id will have the last_updated changed to the current date.
Delete the movie.title from the display in the list view.

Function 7: get_reviews_by_user  
Description: A user can view their reviews list and it will display a list of the movies they reviewed and how it was rated.
Input: USER.username
Steps:
Given the user’s username, find the matching entities in the “reviews” table.
Display for all the entities the movie_title, num_stars, and review_text.
    
Function 8: create_user
Description: New users can create a username and password on the create user page
Input: USER.username, USER.password
Steps
A user can enter a username and password to set their user profile
The information is then sent to the databases where it will check to see if there is any users that have the same username.
If the username is unique to the database then a user profile is created and stored in the database. 
Otherwise the application will ask the user to create a new username

Function 9:   Login
Description: Existing users can login into their movie lists by entering their username and password on the login screen.
Input: USER.username, USER.password
Steps
The user is asked to provide their username and password on the login page.
Once the user submits their information, the username is then compared to all existing users under USERS.username.
Once it finds the correct username the database then compares the password the user provides to the selected USER.password.
If everything matches then the user will be allowed access to the application
If the username or password does not match then the user will be asked to re enter their information

Function 10: delete_list
Description: A user can delete a pre-existing list that they’ve created.
Input: USER.username and LIST.id
Steps:
A user can press the delete button in the list view.
First, the list.id is compared to the “in” table to find all the entities with matching list.ids.
These entities are deleted from the “in” table.
Using the selected list.id, the entity with matching list.id is deleted from the “list” table.

Function 11: delete_review
Description: A user can delete a pre-existing review that they’ve created.
Input: USER.username, MOVIE.id
Steps:
The user clicks on the delete review button.
The database then selects from the table the movie that they had left a review on using MOVIE.id
Once it’s selected the databases will remove the review that is associated with USER.username

Function 12: modify_list
Description: A user can modify a pre-existing list’s name and/or description.
Input: list.id, string for name, string for description
Steps:
Find the list entity in the “list” table using the given id.
Change the name or description of the entity to the given input.
Change the last_updated part of the entity to the current date.


Administrator Functions

Function 1: insert_movie
Description: An administrator can add a movie into the database along with additional data that is related to that movie. 
Input: title, release_date, genre, gross_revenue. Production company name and biography. A list of person.id’s involved, including position and description. A list of awards, for each award include award.name, award.show, and year.
Steps:
Generate a random movie id
Create a new entity in “movie” table which includes the following: the generated movie id, the title, release date, genre, and gross revenue
Create an entity in the “production_company” table which included the movie_id, company name, and company biography.
For each person.id, do the following:
Verify that the given person.id exists in the “person” table.
If they do exist, create a new entity in the “involved with” table that includes movie.id, person.id, position, and description
For each award, do the following:
Create a new entity in the “award” table which consists of movie.id, aware_show, award_name, and year.

Function 2:  delete_movie
Description: An administrator can delete a movie record from the database
Input: MOVIE.id
Steps:
First, find all matching movie.ids in tables “in”, “reviews”, and “involved with”. 
Remove the matching entities from each table.
Find the matching movie ids for “award” and “production company” tables.
Remove the matching entities from those tables.
Lastly, remove the movie from the “movie” table.

Function 3:  modify_movie
Description: An administrator can modify a selected movie record. They can modify the title, release date, genre, gross revenue, a person involved, production company, or an award involved.
Input: movie.id, any information to be altered (title, release_date, genre, gross_revenue, award (award_show, award_name, year), person involved (position, description), or production company (name, biography)). Also include string to specify what needs to be modified (“title”, “release_date”, “genre”, “gross_revenue”, “award”, “person_involved”, or “production_ company”).
Steps:
If title, release_date, genre, or gross_revenue is changed, find the entity for the given movie.id in the “movie” table. Then change the value.
For title change, also find the matching movie.id in the “in” or “reviews” table and change the movie title there as well.
For award, if the specified award information is present within the “award” table, delete it. If it is not, add a new entity to the “award” table with the given information.
For production company, like the award, search the “production_ company” table for the movie.id and the given input information. If all the information is matching, delete it from the table. If not, replace the current “production_company” entity with matching movie.id with the new information.
For a person involved, search “involved with” table for a person with matching person.id and movie.id. If they exist, change the information to the given input. If the person is not in “involved with” but is in “person” table, add this person to the “involved with” table with all the given information. Else, if the person.id does not exist in “person”, don’t do anything and display an error message back to the user.

 Function 4:   Delete a user account
Description An administrator can remove a user account for any reason 
Input: USER.username
Steps:
The administrator enters the username of the user that  they wish to remove
The database then looks for a user under USER.username that has the same username as the provided username.
Once it has been found the database then looks for any lists or reviews that the user has created. 
If it finds a review or list that was created by the user it should remove it from the database.
Once it done with removing the records made by the user it should then at the end remove the record of the user from USER.

Function 5: add_person
Description: Adds a person who was involved in the creation of a movie.
Input: person_name, person_gender, biography(Optional)
Steps:
Have the user enter the details of the person they want to add to the database
Generate a unique key for the new persons id 
Insert the new person record into the database.
Function 6: delete_person
Description: Delete a person who was involved in the creation of a movie 
Input: PERSON. Person_id
Steps
The user enter provides the person_id that they wish to remove from the database
The database then finds all related entities that are related to the selected person within INVOLVED_IN
The database removes any entities that related to that person from INVOLVED_IN
Afterwards remove the select person record from USERS.

Function 7:modify person
Description: modifies a person record 
Input: PERSON.Person_id, (any information that needs to be changed such as name, gender, biography, role, position, description), MOVIE.movie_id
Steps:
The user provides the person_id plus whatever information they wish to change
Depending on the info that the user provides two situations may aries
If the user wishes to change the name, gender, biography of a person
  The database then goes into the PERSON table and finds the record containing the user provided person_id.
Then it changes whatever info the user wishes to change within the record.
If the user wishes to change the role, position, description that a person had in the creation of a movie 
The database goes into the INVOLVED_IN table and finds the corresponding record that contains both the person_id, and movie_id corresponds with the user provided info.
Once the record has been selected it then changes whatever data the user wished to change.
        
Function 8: insert_person_into_movie (the 
Description: Insert a person role into a movie 
Input: PERSON.person_id, MOVIE.id, string position, 
Steps
User provides the necessary info for the function
Database then selects both the person record and movie based on both id’s
Database then inserts into INVOLVED_IN both the person info, the movie title and the role which the person was assigned in the creation of the movie.
*/