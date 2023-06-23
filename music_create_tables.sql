CREATE TABLE IF NOT EXISTS genres(
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) UNIQUE NOT NULL
	);
CREATE TABLE IF NOT EXISTS performers(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
	);
CREATE TABLE IF NOT EXISTS albums(
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	year INTEGER NOT NULL CHECK (year BETWEEN 1900 and 2100)
	);
CREATE TABLE IF NOT EXISTS tracks(
	id SERIAL PRIMARY KEY,
	album_id INTEGER NOT NULL REFERENCES albums (id),
	name VARCHAR(80) NOT NULL,
	duration INTERVAL MINUTE TO SECOND NOT NULL
	);
CREATE TABLE IF NOT EXISTS compilation_albums(
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	year INTEGER NOT NULL CHECK (year BETWEEN 1900 and 2100)
	);
CREATE TABLE IF NOT EXISTS genre_performer(
	genre_id INTEGER NOT NULL REFERENCES genres (id),
	performer_id INTEGER NOT NULL REFERENCES performers (id),
	PRIMARY KEY (genre_id, performer_id)
	);
CREATE TABLE IF NOT EXISTS album_performer(
	album_id INTEGER NOT NULL REFERENCES albums (id),
	performer_id INTEGER NOT NULL REFERENCES performers (id),
	PRIMARY KEY (album_id, performer_id)
	);
CREATE TABLE IF NOT EXISTS track_compilation(
	track_id INTEGER NOT NULL REFERENCES tracks (id),
	compilation_id INTEGER NOT NULL REFERENCES compilation_albums (id),
	PRIMARY KEY (track_id, compilation_id)
	);