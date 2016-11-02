CREATE DATABASE mytunes;

-- USERS LOGIN
CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  password_digest VARCHAR(400),
  username VARCHAR(100)
);

DELETE FROM users
WHERE ID = 5;


-- Belong to User.  Types:- All, Albums, Playlists, UpNext - May have to add to user when created the All and UpNext playlists
CREATE TABLE playlists (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  name VARCHAR(400)
);



-- Belong to collections by default - USER, ALL,
CREATE TABLE songs (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  location_url TEXT NOT NULL,
  artist VARCHAR(400),
  title VARCHAR(400),
  album VARCHAR(400),
  genre VARCHAR(400)
);


-- Joining TABLE
CREATE TABLE playlists_songs (
  playlists_id INTEGER,
  songs_id INTEGER
);



-- Belong to songs.
CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  description VARCHAR(100)
  -- FIELDS TO BE ADDED
);
