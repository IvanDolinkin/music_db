INSERT INTO performers (name)
VALUES 	('Metallica'),
		('Slayer'),
		('Megadeth'),
		('Anthrax'),
		('ПИТОН'),
		('Anacondaz'),
		('Cobra'),
		('Grandmaster Flash and the Furious Five');

INSERT INTO genres (name)
VALUES 	('thrash metal'),
		('русский рэп'),
		('pop'),
		('hip hop'),
		('rap rock');
	
INSERT INTO albums (name, year)
VALUES 	('Master of Puppets', 1986),
		('Garage Inc.', 1998),
		('Мои дети не будут скучать', 2019),
		('I Disappear', 2000),
		('Test album', 2023);

INSERT INTO tracks (album_id, name, duration)
VALUES 	(1, 'Battery', '5:13'),
		(1,	'Master of Puppets', '8:36'),
		(1,	'The Thing That Should Not Be', '6:37'),
		(1,	'Welcome Home (Sanitarium)',	'6:28'),
		(1,	'Disposable Heroes',	'8:17'),
		(1,	'Leper Messiah',	'5:41'),
		(1,	'Orion',	'8:28'),
		(1,	'Damage, Inc.',	'5:30'),
		(2, 'Free Speech for the Dumb', '2:36'),
		(2, 'Die, Die My Darling', '2:29'),
		(3, 'Мои дети не будут скучать', '1:36'),
		(3, 'Пусть они умрут', '6:25'),
		(3, 'Всё хорошо', '4:28'),
		(3, 'Гуд-трип', '2:44'),
		(3, 'Синий кит', '3:12'),
		(3, 'Новый приют', '2:25'),
		(3, 'Иди за второй', '3:49'),
		(3, 'Бойня номер шесть', '3:56'),
		(4, 'I Disappear', '4:26'),
		(5, 'Myself', '2:23'),
		(5, 'Моя', '2:22');

INSERT INTO compilation_albums (name, year)	
VALUES	('Classic Rock Gold', 2005),
		('Come and Get It: The Best of Apple Records', 2010),
		('VH1: I Love the ''80s', 2004),
		('Ray', 2004),
		('Everything Hits at Once: The Best of Spoon', 2019),
		('The Beatles: 50th Anniversary Edition', 2018),
		('Music from and Inspired by Mission: Impossible 2', 2000);
	
INSERT INTO genre_performer (genre_id, performer_id)	
VALUES	(1, 1),
		(1, 2),
		(1, 3),
		(1, 4),
		(2, 5),
		(2, 6),
		(3, 7),
		(4, 8),
		(5, 6);
		
INSERT INTO album_performer (album_id, performer_id)	
VALUES	(1, 1),
		(2, 1),
		(3, 6),
		(4, 1);
	
INSERT INTO track_compilation (track_id, compilation_id)	
VALUES	(19, 7);
