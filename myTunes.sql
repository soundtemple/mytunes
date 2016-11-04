CREATE DATABASE mytunes;

-- USERS LOGIN
CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  password_digest VARCHAR(400),
  username VARCHAR(100)
);





-- Belong to collections by default - USER, ALL,
CREATE TABLE songs (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  location_url TEXT NOT NULL,
  artist VARCHAR(400),
  title VARCHAR(400),
  album VARCHAR(400),
  genre VARCHAR(400),
  song_type VARCHAR(100),
  song_file TEXT
);




-- OTHER....
ALTER TABLE songs ADD COLUMN song_type VARCHAR(100);
ALTER TABLE songs ADD COLUMN song_file TEXT;

DELETE FROM users
WHERE ID = 5;

UPDATE songs SET user_id = 11;
