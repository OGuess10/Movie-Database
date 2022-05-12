-- --------------------- --

-- Creating the Database --

-- --------------------- --

CREATE DATABASE MovieDatabase;
USE MovieDatabase;

CREATE TABLE ACCOUNT(
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY(username)
);
CREATE TABLE ACCOUNT_LIST(
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
CREATE TABLE SCREENWRITER(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
);
CREATE TABLE ACTOR(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
);
CREATE TABLE DIRECTOR(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
);
CREATE TABLE FILM_CREW(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
);
CREATE TABLE EXEC_PRODUCER(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
);
CREATE TABLE PRODUCER(
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id)
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
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id)
);
CREATE TABLE AWARD(
    movie_id INT NOT NULL,
    award_show VARCHAR(255) NOT NULL,
    award_name VARCHAR(255) NOT NULL,
    award_year INT NOT NULL,
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id)
);
CREATE TABLE PRODUCTION_COMPANY(
    movie_id INT NOT NULL,
    company_name VARCHAR(255),
    biography VARCHAR(2047),
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id)
);
CREATE TABLE INVOLVED_WITH(
    movie_id INT NOT NULL,
    person_id INT NOT NULL,
    position VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
    FOREIGN KEY(person_id) REFERENCES PERSON(person_id),
    PRIMARY KEY(movie_id, person_id)
);

CREATE TABLE REVIEWS(
    username VARCHAR(255) NOT NULL,
    movie_id INT NOT NULL,
    num_stars INT NOT NULL,
    review_text VARCHAR(2047) NOT NULL,
    FOREIGN KEY(username) REFERENCES ACCOUNT(username),
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
    PRIMARY KEY(username, movie_id)
);

CREATE TABLE IN_LIST(
    list_id INT NOT NULL,
    movie_id INT NOT NULL,
    movie_title VARCHAR(255),
    FOREIGN KEY(list_id) REFERENCES ACCOUNT_LIST(list_id),
    FOREIGN KEY(movie_id) REFERENCES MOVIE(movie_id),
    PRIMARY KEY(list_id, movie_id)
);

CREATE TABLE CURATES(
    username VARCHAR(255) NOT NULL,
    list_id INT NOT NULL,
    FOREIGN KEY(username) REFERENCES ACCOUNT(username),
    FOREIGN KEY(list_id) REFERENCES ACCOUNT_LIST(list_id),
    PRIMARY KEY(username, list_id)
);