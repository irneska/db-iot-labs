CREATE DATABASE iryna_pistun;
USE iryna_pistun;

-- tables
-- Table: album
CREATE TABLE album (
    id int NOT NULL,
    name varchar(45) NULL,
    year_of_publishing int NULL,
    musical_label_id int NOT NULL,
    CONSTRAINT album_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL,
    name varchar(45) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: current_song
CREATE TABLE current_song (
    id int NOT NULL,
    song_id int NOT NULL,
    CONSTRAINT current_song_pk PRIMARY KEY (id)
);

-- Table: genre
CREATE TABLE genre (
    id int NOT NULL,
    name varchar(45) NULL,
    CONSTRAINT genre_pk PRIMARY KEY (id)
);

-- Table: musical_label
CREATE TABLE musical_label (
    id int NOT NULL,
    name varchar(45) NULL,
    CONSTRAINT musical_label_pk PRIMARY KEY (id)
);

-- Table: musician
CREATE TABLE musician (
    id int NOT NULL,
    first_name varchar(45) NULL,
    last_name varchar(45) NULL,
    album_id int NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT musician_pk PRIMARY KEY (id)
);

-- Table: playlist
CREATE TABLE playlist (
    id int NOT NULL,
    number_of_songs int NOT NULL,
    CONSTRAINT playlist_pk PRIMARY KEY (id)
);

-- Table: song
CREATE TABLE song (
    id int NOT NULL,
    duration double(2,2) NULL,
    name varchar(45) NULL,
    album_id int NOT NULL,
    genre_id int NOT NULL,
    CONSTRAINT song_pk PRIMARY KEY (id)
);

-- Table: user
CREATE TABLE user (
    id int NOT NULL,
    first_name varchar(45) NULL,
    last_name varchar(45) NULL,
    current_song_id int NOT NULL,
    playlist_id int NOT NULL,
    user_saved_songs_id int NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
);

-- Table: user_saved_songs
CREATE TABLE user_saved_songs (
    id int NOT NULL,
    number_of_songs int NULL,
    song_id int NOT NULL,
    CONSTRAINT user_saved_songs_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: album_musical_label (table: album)
ALTER TABLE album ADD CONSTRAINT album_musical_label FOREIGN KEY album_musical_label (musical_label_id)
    REFERENCES musical_label (id);

-- Reference: current_song_song (table: current_song)
ALTER TABLE current_song ADD CONSTRAINT current_song_song FOREIGN KEY current_song_song (song_id)
    REFERENCES song (id);

-- Reference: musician_album (table: musician)
ALTER TABLE musician ADD CONSTRAINT musician_album FOREIGN KEY musician_album (album_id)
    REFERENCES album (id);

-- Reference: musician_country (table: musician)
ALTER TABLE musician ADD CONSTRAINT musician_country FOREIGN KEY musician_country (country_id)
    REFERENCES country (id);

-- Reference: song_album (table: song)
ALTER TABLE song ADD CONSTRAINT song_album FOREIGN KEY song_album (album_id)
    REFERENCES album (id);

-- Reference: song_genre (table: song)
ALTER TABLE song ADD CONSTRAINT song_genre FOREIGN KEY song_genre (genre_id)
    REFERENCES genre (id);

-- Reference: user_saved_songs_song (table: user's_saved_songs)
ALTER TABLE user_saved_songs ADD CONSTRAINT user_saved_songs_song FOREIGN KEY user_saved_songs_song (song_id)
    REFERENCES song (id);

-- Reference: user_current_song (table: user)
ALTER TABLE user ADD CONSTRAINT user_current_song FOREIGN KEY user_current_song (current_song_id)
    REFERENCES current_song (id);

-- Reference: user_playlist (table: user)
ALTER TABLE user ADD CONSTRAINT user_playlist FOREIGN KEY user_playlist (playlist_id)
    REFERENCES playlist (id);

-- Reference: user_user's_saved_songs (table: user)
ALTER TABLE user ADD CONSTRAINT user_user_saved_songs FOREIGN KEY user_user_saved_songs (user_saved_songs_id)
    REFERENCES user_saved_songs (id);

-- End of file.genre
