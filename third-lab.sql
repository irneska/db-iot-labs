CREATE DATABASE IF NOT EXISTS spotify_db;
USE spotify_db;

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS user_saved_songs;
DROP TABLE IF EXISTS current_song;
DROP TABLE IF EXISTS musician;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS musical_label;

CREATE TABLE IF NOT exists `musical_label` (
  `id` 						int NOT NULL,
  `name` 					varchar(45),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `playlist` (
  `id` 						int NOT NULL,
  `number_of_songs` 		int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `country` (
  `id` 						int NOT NULL,
  `name` 					varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `genre` (
  `id` 						int NOT NULL,
  `name` 					varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `album` (
  `id` 						int NOT NULL,
  `name` 					varchar(45) DEFAULT NULL,
  `year_of_publishing` 		int DEFAULT NULL,
  `musical_label_id` 		int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `album_musical_label` FOREIGN KEY (`musical_label_id`) REFERENCES `musical_label` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `song` (
  `id` 						int NOT NULL,
  `duration` 				double(8,2) DEFAULT NULL,
  `name` 					varchar(45) DEFAULT NULL,
  `album_id` 				int NOT NULL,
  `genre_id` 				int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `song_album` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `song_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `musician` (
  `id` 						int NOT NULL,
  `first_name` 				varchar(45) DEFAULT NULL,
  `last_name` 				varchar(45) DEFAULT NULL,
  `album_id` 				int NOT NULL,
  `country_id` 				int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `musician_album` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `musician_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `current_song` (
  `id` 						int NOT NULL,
  `song_id` 				int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `current_song_song` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `user_saved_songs` (
  `id` 						int NOT NULL,
  `song_id` 				int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_saved_songs_song` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT exists `user` (
  `id` 						int NOT NULL,
  `first_name` 				varchar(45) DEFAULT NULL,
  `last_name` 				varchar(45) DEFAULT NULL,
  `current_song_id` 		int NOT NULL,
  `playlist_id` 			int NOT NULL,
  `user_saved_songs_id` 	int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_current_song` FOREIGN KEY (`current_song_id`) REFERENCES `current_song` (`id`),
  CONSTRAINT `user_playlist` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `user_user_saved_songs` FOREIGN KEY (`user_saved_songs_id`) REFERENCES `user_saved_songs` (`id`)
) ENGINE=InnoDB;

INSERT INTO `musical_label` VALUES (1,'Vidlik Records'),(2,'Enko'),(3,'Enjoy Records'),(4,'Vidlik Records'),(5,'mamamusic'),(6,'Enko'),(7,'Enjoy Records'),(8,'Vidlik Records'),(9,'mamamusic'),(10,'Enko');
INSERT INTO `playlist` VALUES (1,10),(2,7),(3,15),(4,30),(5,12),(6,27),(7,21),(8,24),(9,17),(10,19);
INSERT INTO `country` VALUES (1,'Ukraine'),(2,'France'),(3,'USA'),(4,'Ukraine'),(5,'Spain'),(6,'Portugal'),(7,'Ukraine'),(8,'USA'),(9,'France'),(10,'England');
INSERT INTO `genre` VALUES (1,'Pop'),(2,'Hip hop'),(3,'Jazz'),(4,'Disco'),(5,'Rock'),(6,'Soul music'),(7,'Funk'),(8,'Folk'),(9,'Electronic music'),(10,'Classical');
INSERT INTO `album` VALUES (1,'Vidlik',2016,4),(2,'HOTIN',2021,8),(3,'Люди',2015,9),(4,'Galas',2021,3),(5,'Kolir',2021,1),(6,'Крила',2018,7),(7,'Без меж',2016,2),(8,'Земля',2013,6),(9,'Один в каное',2016,5),(10,'Dolce Vita',2010,10);
INSERT INTO `song` VALUES (1,2.10,'Люди',3,3),(2,1.10,'Обійми',7,7),(3,2.45,'Човен',9,2),(4,3.43,'Зорі',2,5),(5,4.04,'NA SAMOTI',5,1),(6,3.01,'На лінії вогню',10,9),(7,4.35,'Любити',6,6),(8,4.40,'Vidlik',1,4),(9,3.22,'Dym',4,10),(10,3.42,'На небі',8,8);
INSERT INTO `musician` VALUES (1,'Sviatoslav','Vakarchuk',7,1),(2,'Andriy','Khlyvniyk',3,4),(3,'Nata','Zhyzhchenko',5,8),(4,'Alyona','Alyona',4,3),(5,'Sviatoslav','Vakarchuk',8,6),(6,'Kalush','group',2,10),(7,'Nata','Zhyzhchenko',1,5),(8,'Jamala','singer',6,7),(9,'Iryna','Shvaidak',9,2),(10,'Sviatoslav','Vakarchuk',10,9);
INSERT INTO `current_song` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
INSERT INTO `user_saved_songs` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
INSERT INTO `user` VALUES (1,'Iryna','Pistun',10,1,7),(2,'Vasyl','Petrenko',9,2,2),(3,'Marko','Yaminskiy',8,3,3),(4,'Denys','Izhyk',7,4,5),(5,'Igor','Vilkov',6,5,9),(6,'Pavlo','Turchynyak',5,6,8),(7,'Zenoviy','Veres',4,7,6),(8,'Andriy','Pavelchak',3,8,1),(9,'Yulia','Ivanets',2,9,4),(10,'Alina','Maksymiv',1,10,10);

CREATE INDEX song_idx ON song(name, duration);
CREATE INDEX musician_idx ON musician(first_name, last_name);

SHOW INDEX FROM song;
SHOW INDEX FROM musician;
