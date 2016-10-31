CREATE DATABASE mytunes;

-- USERS LOGIN
CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  password_digest VARCHAR(400)
);

-- Belong to User.  Types:- All, Albums, Playlists, UpNext
CREATE TABLE collections (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  name VARCHAR(400)
);

CREATE TABLE collection_types (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  name VARCHAR(400)
);

-- Belong to collections.
CREATE TABLE songs (
  id SERIAL4 PRIMARY KEY,
  location_url TEXT NOT NULL,
  artist VARCHAR(400),
  title VARCHAR(400),
  bpm INTEGER,
  key VARCHAR(100),
  genre VARCHAR(400),
  duration VARCHAR(100)
);


-- Belong to songs.
CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  description VARCHAR(100)
  -- FIELDS TO BE ADDED
);
