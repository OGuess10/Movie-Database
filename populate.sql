-- --------------------- --

-- Populting the Database --

-- --------------------- --


-- -------------- --
-- User Functions --
-- -------------- --

-- Function 5: Add Movie Rating --
INSERT INTO REVIEWS
	VALUES("user", "1", "5", "This is the best movie!"),
    ("user", "2", "3", "I don't remember this movie at all.");
INSERT INTO REVIEWS
	VALUES("user2", "2", "4", "This movie was pretty good.");




-- --------------- --
-- Admin Functions --
-- --------------- --

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

INSERT INTO MOVIE
	VALUES("2", "Avatar", "2009-12-18", 2847000000000);
INSERT INTO MOVIE_GENRE
	VALUES("2", "Science Fiction");
INSERT INTO PRODUCTION_COMPANY
	VALUES("2", "20th Century Fox", "20th Century Studios, Inc., formerly known as 20th Century Fox, is an American film production studio headquartered at the Fox Studio Lot in the Century City area of Los Angeles.[6] It is a subsidiary of Walt Disney Studios, a division of The Walt Disney Company.[7] Walt Disney Studios Motion Pictures distributes and markets the films made under the 20th Century Studios brand.");
INSERT IGNORE INTO PERSON
	VALUES("4", "James Cameron", "Male", "James Francis Cameron CC (born August 16, 1954) is a Canadian filmmaker. Best known for making science fiction and epic films, he first gained recognition for directing The Terminator (1984).");
INSERT IGNORE INTO DIRECTOR
	VALUES("4");
INSERT INTO INVOLVED_WITH
	VALUES("2", "4", "Director", "Cameron directed Avatar.");
INSERT INTO AWARD
	VALUES("2", "Oscars", "Academy Award for Best Cinematography", 2010);

-- Function 4: Add To List --
INSERT IGNORE INTO IN_LIST
	VALUES ((SELECT ACCOUNT_LIST.list_id FROM ACCOUNT_LIST, ACCOUNT, CURATES WHERE ACCOUNT.username = "user" AND CURATES.username = "user" AND CURATES.list_id = ACCOUNT_LIST.list_id AND ACCOUNT_LIST.name = "Favorites"), (SELECT movie_id FROM MOVIE WHERE title = "La La Land"), "La La Land");
UPDATE ACCOUNT_LIST, CURATES, ACCOUNT
	SET last_updated = CURDATE()
    WHERE (SELECT ACCOUNT_LIST.list_id FROM ACCOUNT_LIST, ACCOUNT, CURATES WHERE ACCOUNT.username = "user" AND CURATES.username = "user" AND CURATES.list_id = ACCOUNT_LIST.list_id AND ACCOUNT_LIST.name = "Favorites") = ACCOUNT_LIST.list_id;

 -- Function 8: Create User --
INSERT IGNORE INTO ACCOUNT
	VALUES("user", "password");

INSERT IGNORE INTO ACCOUNT
	VALUES("user2", "password2");

-- Function 3: Create User List --
INSERT INTO ACCOUNT_LIST
	VALUES("1", "Favorites", "This is a list of my all time favorite movies.", CURDATE(), NULL);
INSERT INTO CURATES
	VALUES("user", "1");
