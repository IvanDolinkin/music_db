create table if not exists genres (
	id serial primary key,
	name varchar(80) not null
	);
create table if not exists performers (
	id serial primary key,
	name varchar(100) not null
	);
	create table if not exists albums (
	id serial primary key,
	name varchar(80) not null,
	year integer not null
	);
create table if not exists tracks (
	id serial primary key,
	album_id integer not null references albums (id),
	name varchar(80) not null,
	duration integer not null
	);
create table if not exists compilation_albums (
	id serial primary key,
	name varchar(80) not null,
	year integer not null
	);
create table if not exists genre_performer (
	genre_id integer not null references genres (id),
	performer_id integer not null references performers (id)
	);
create table if not exists album_performer (
	album_id integer not null references albums (id),
	performer_id integer not null references performers (id)
	);
create table if not exists track_compilation (
	track_id integer not null references tracks (id),
	compilation_id integer not null references compilation_albums (id)
	);