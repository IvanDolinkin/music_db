--Название и продолжительность самого длительного трека
SELECT name, duration
FROM tracks
ORDER BY duration DESC
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM tracks
WHERE duration >= '210'
ORDER BY name;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM compilation_albums
WHERE year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова
SELECT name
FROM performers
WHERE name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my». Вариант 1
SELECT name
FROM tracks 				/* Имя трека из таблицы треков */
WHERE name ILIKE 'my %'		/* Где слово в начале строки */
OR name ILIKE '% my' 		/* Где слово в конце строки */
OR name ILIKE '% my %'		/* Где слово в середине строки */
OR name ILIKE 'my' 			/* Где название трека состоит из одного искомого слова */
OR name ILIKE 'мо_ %'
OR name ILIKE '% мо_'
OR name ILIKE '% мо_ %'
OR name ILIKE 'мо_';

--Название треков, которые содержат слово «мой» или «my». Вариант 2
SELECT name
FROM tracks
WHERE string_to_array(lower(name), ' ') && ARRAY['my', 'мой', 'моя', 'мои'];

--Название треков, которые содержат слово «мой» или «my». Вариант 3
SELECT name
FROM tracks
WHERE name ~* '(^my | my$| my |^my$)'
OR name ~* '(^мо. | мо.$| мо. |^мо.$)';

--Количество исполнителей в каждом жанре
SELECT genre_id, COUNT (performer_id)
FROM genre_performer
GROUP BY genre_id
ORDER BY genre_id;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id)
FROM tracks AS t
JOIN albums AS a ON a.id = t.album_id
WHERE a.year BETWEEN 2019 and 2020;

--Средняя продолжительность треков по каждому альбому
SELECT a.name, AVG(t.duration)
FROM albums AS a 
JOIN tracks AS t ON a.id = t.album_id
GROUP BY a.name
ORDER BY AVG(t.duration);

--Все исполнители, которые не выпустили альбомы в 2020 году (изменил на 2000 для наглядности)
SELECT name
FROM performers
WHERE name !=
(SELECT p.name
FROM performers AS p
JOIN album_performer AS ap ON p.id = ap.performer_id
JOIN albums AS a ON a.id = ap.album_id
WHERE a.year = 2000);

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT ca.name, p.name
FROM compilation_albums AS ca
JOIN track_compilation AS tc ON ca.id = tc.compilation_id
JOIN tracks AS t ON t.id = tc.track_id
JOIN albums AS a ON a.id = t.album_id
JOIN album_performer AS ap ON a.id = ap.album_id
JOIN performers AS p ON p.id = ap.performer_id
WHERE p.name = 'Metallica';

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT a.name
FROM albums AS a
JOIN album_performer AS ap ON a.id = ap.album_id
JOIN performers AS p ON p.id = ap.performer_id
JOIN genre_performer AS gp ON p.id = gp.performer_id
GROUP BY a.name, p.id
HAVING COUNT(gp.genre_id) > 1;

--Наименования треков, которые не входят в сборники
SELECT name
FROM tracks AS t
LEFT JOIN track_compilation AS tc ON t.id = tc.track_id
WHERE tc.track_id IS NULL;

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT p.name 											 	/* Имена исполнителей */
FROM performers AS p 									 	/* Из таблицы исполнителей */
JOIN album_performer AS ap ON p.id = ap.performer_id 		/* Объединяем с промежуточной таблицей между исполнителями и альбомами */
JOIN albums AS a ON a.id = ap.album_id 						/* Объединяем с таблицей альбомов*/
JOIN tracks AS t ON a.id = t.album_id 						/* Объединяем с таблицей треков */
WHERE t.duration = ( 										/* Где длительность трека равна вложенному запросу */
    SELECT MIN(duration) FROM tracks AS t 					/* Получаем минимальную длительность из таблицы треков */
	JOIN album_performer AS ap ON t.album_id = ap.album_id	/* Объединяем таблицу треков с промежуточной таблицей между альбомами и исполнителями на основе айди альбомов */
);

--Названия альбомов, содержащих наименьшее количество треков
SELECT a.name 								/* Названия альбомов */
FROM albums AS a 
JOIN tracks AS t ON a.id = t.album_id		/* Объединяем альбомы и треки */
GROUP BY a.id 								/* Группируем по айди альбомов */
HAVING COUNT(t.id) = ( 						/* Где количество треков равно вложенному запросу, в котором получаем наименьшее количество треков в одном альбоме */
    SELECT COUNT(id) FROM tracks 			/* Получаем поличество айди треков из таблицы треков*/
    GROUP BY album_id 						/* Группируем по айди альбомов */
    ORDER BY 1 								/* Сортируем по первому столбцу */
    LIMIT 1 								/* Получаем первую запись */
);
