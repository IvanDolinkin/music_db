ALTER TABLE albums
ADD CONSTRAINT y_con CHECK (year BETWEEN 1900 and 2100);
ALTER TABLE compilation_albums
ADD CONSTRAINT y_con CHECK (year BETWEEN 1900 and 2100);
ALTER TABLE genres
ADD CONSTRAINT unq UNIQUE (name);

ALTER TABLE album_performer
ADD CONSTRAINT ap_pk PRIMARY KEY (album_id, performer_id);
ALTER TABLE genre_performer
ADD CONSTRAINT gp_pk PRIMARY KEY (genre_id, performer_id);
ALTER TABLE track_compilation
ADD CONSTRAINT pk PRIMARY KEY (track_id, compilation_id);

ALTER TABLE tracks DROP duration;

ALTER TABLE tracks ADD duration INTERVAL MINUTE TO SECOND NOT NULL;
