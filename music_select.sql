--Название и продолжительность самого длительного трека
SELECT name, duration
FROM tracks
ORDER BY duration DESC
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM tracks
WHERE duration <= '210'
ORDER BY name;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM compilation_albums
WHERE year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова
SELECT name
FROM performers
WHERE name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM tracks
WHERE name LIKE '%My%' OR name LIKE '%Мо_ %';

--Количество исполнителей в каждом жанре
SELECT genre_id, COUNT (performer_id)
FROM genre_performer
GROUP BY genre_id
ORDER BY genre_id;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT a.name, a.year, COUNT(t.name)
FROM albums AS a 
JOIN tracks AS t ON a.id = t.album_id
WHERE album_id = (SELECT id FROM albums WHERE year BETWEEN 2019 AND 2020)
GROUP BY a.name, a.year;

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
SELECT a.name 
FROM albums AS a
JOIN album_performer AS ap ON a.id = ap.album_id
JOIN performers AS p ON p.id = ap.performer_id
JOIN genre_performer AS gp ON p.id = gp.performer_id 
GROUP BY a.name
HAVING  count(gp.genre_id) > 1;

--Наименования треков, которые не входят в сборники
SELECT name
FROM tracks
WHERE name !=
(SELECT t.name
FROM tracks AS t 
JOIN track_compilation AS tc ON t.id = tc.track_id 
JOIN compilation_albums AS ca ON ca.id = tc.compilation_id)
ORDER BY name;

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT p.name, t.name, t.duration 
FROM performers AS p 
JOIN album_performer AS ap ON p.id = ap.performer_id
JOIN albums AS a ON a.id = ap.album_id
JOIN tracks AS t ON a.id = t.album_id 
GROUP BY t.duration, p.name, t.name
ORDER BY t.duration
LIMIT 1;

--Названия альбомов, содержащих наименьшее количество треков
SELECT a.name, count(t.name) 
FROM albums AS a 
JOIN tracks AS t ON a.id = t.album_id
GROUP BY a.name
ORDER BY count(t.name)
LIMIT 1;
