--Dropping tables for consistency
DROP TABLE album;
DROP TABLE artist;
DROP TABLE genre;
DROP TABLE mediatype;
DROP TABLE track;

--creating tables
CREATE TABLE artist (
    artistID int NOT NULL
    , name varchar2(120) NOT NULL
);
CREATE TABLE genre (
    genreID int NOT NULL
    , name varchar2(120) NOT NULL
);
CREATE TABLE mediatype (
    mediaTypeID int NOT NULL
    , name varchar2(120) NOT NULL
);
CREATE TABLE album (
    albumID int NOT NULL
    , title varchar2(160) NOT NULL
    , artistID int NOT NULL
);
CREATE TABLE track (
    trackID int NOT NULL
    , name varchar2(200) NOT NULL
    , albumID int
    , genreID int
    , Composer varchar2(220)
    , miliseconds int NOT NULL
    , bytes int NOT NULL
    , unitPrice decimal(10,2)
);

--create primary keys
ALTER TABLE artist
ADD CONSTRAINT PK_artist
Primary Key (artistID);

ALTER TABLE genre
ADD CONSTRAINT PK_genre
Primary Key (genreID);

ALTER TABLE mediatype
ADD CONSTRAINT PK_mediaType
Primary Key (mediaTypeID);

ALTER TABLE album
ADD CONSTRAINT PK_album
Primary Key (albumID);

ALTER TABLE track
ADD CONSTRAINT PK_track
Primary Key (trackID);

--add foreign keys

--artist has NO FK
--genre has NO FK
--mediaType has NO FK
--album has FK, artistID
--track has FK, albumID, mediaTypeID, genreID
ALTER TABLE track
ADD CONSTRAINT FK_track_albumID
Foreign Key (albumID) REFERENCES album (albumID);

ALTER TABLE track
ADD CONSTRAINT FK_track_mediaTypeID
Foreign Key (mediaTypeID) REFERENCES mediatype (mediaTypeID);

ALTER TABLE track
ADD CONSTRAINT FK_track_genreID
Foreign Key (genreID) REFERENCES genre (genreID);

--populating data in tables
INSERT INTO genre (genreID, name)
VALUES
(1, 'Rock'),
(2, 'Jazz'),
(3, 'Metal'),
(4, 'Alternative Punk'),
(5, 'Rock and Roll'),
(6, 'Blues'),
(7, 'Latin'),
(8, 'Reggae'),
(9, 'Pop'),
(10, 'Soundtrack'),
(11, 'Bossa Nova'),
(12, 'Easy Listening'),
(13, 'Heavy Metal'),
(14, 'RB Soul'),
(15, 'Electronica Dance'),
(16, 'World'),
(17, 'Hip Hop Rap'),
(18, 'Science Fiction'),
(19, 'TV Shows'),
(20, 'Sci Fi and Fantasy'),
(21, 'Drama'),
(22, 'Comedy'),
(23, 'Alternative'),
(24, 'Classical'),
(25, 'Opera');

INSERT INTO mediatype (mediaTypeID, name)
VALUES
(1, 'MPEG audio file'),
(2, 'Protected AAC audio file'),
(3, 'Protected MPEG4 video file'),
(4, 'Purchased AAC audio file'),
(5, 'AAC audio file');

INSERT INTO artist (artistID, name)
VALUES
(1, 'AC DC'),
(2, 'Accept'),
(3, 'Aerosmith'),
(4, 'Alanis Morissette'),
(5, 'Alice In Chains'),
(6, 'Antonio Carlos Jobim'),
(7, 'Apocalyptica'),
(8, 'Audioslave'),
(9, 'BackBeat'),
(10, 'Billy Cobham'),
(11, 'Black Label Society'),
(12, 'Black Sabbath');

INSERT INTO album (albumID, title, artistID)
VALUES
(1, 'For Those Above TO Rock We Salute You', 1),
(2, 'Balls to the Wall', 2), --2
(3, 'Restless and Wild', 3),
(4, 'Let There Be Rock', 1), --4
(5, 'Big Ones', 3),
(6, 'Jagged Little Pill', 4), --6
(7, 'Facelift', 5),
(8, 'Warner 25 Anos', 6), --8
(9, 'Plays Metallica By Four Cellos', 7),
(10, 'Audioslave', 8), --10
(11, 'Out Of Exile', 8),
(12, 'BackBeat Soundtrack', 9), --12
(13, 'The Best Of Billy Cobham', 10),
(14, 'Alcohol Fueled Brewtality Live! [Disc 1]', 11), --14
(15, 'Alcohol Fueled Brewtality Live! [Disc 2]', 11),
(16, 'Black Sabbath', 12), --16
(17, 'Black Sabbath Vol. 4 (Remaster)', 12),
(34, 'Chill: Brazil (Disc 2)', 6), --18
(271, 'Revelations', 8);

INSERT INTO track (trackID, name, albumID, mediaTypeID, genreID, Composer, miliseconds, bytes, unitPrice)
VALUES
--38 Total values
--trackID, name, albumID, mediaTypeID, genreID, Composer, MiliSec, byte, unitPrice
(1, 'For Those About To Rock (We Salute You)', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99),
(6, 'Put The Finger On You', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99),
(2, 'Balls to the Wall', 2, 2, 1,  342562, 5510424, 0.99),
(3, 'Fast As a Shark', 3, 2, 1, 'F. Baltes, S. Kaufman, U. Dirkscneider and W. Hoffman', 230619, 3990994, 0.99),
(4, 'Restless and Wild', 3, 2, 1, 'F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider and W. Hoffman', 252051, 4331779, 0.99),
(16, 'Dog Eat Dog', 4, 1, 1, 'AC DC', 215196, 7032162, 0.99),
(17, 'Let There Be Rock', 4, 1, 1, 'AC DC', 366654, 12021261, 0.99),
(23, 'Walk On Water', 5, 1, 1, 'Steven Tyler, Joe Perry, Jack Blades, Tommy Shaw', 295680, 9719579, 0.99),
(24, 'Love In An Elevator', 5, 1, 1, 'Steven Tyler, Joe Perry', 321828, 10552051, 0.99),
(38, 'All I Really Want', 6, 1, 1, 'Alanis Morissette and Glenn Ballard', 284891, 9375567, 0.99),--10
(39, 'You Oughta Know', 6, 1, 1, 'Alanis Morissette and Glenn Ballard', 249234, 8196916, 0.99),
(40, 'Perfect', 6, 1, 1,'Alanis Morissette and Glenn Ballard', 188133, 6145404, 0.99),
(51, 'We Die Young', 7, 1, 1, 'Jerry Cantrell', 152084, 4925362, 0.99),
(52, 'Man In The Box', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 286641, 9310272, 0.99),
(63, 'Desafinado', 8, 1, 2, '', 185338, 5990473, 0.99),
(64, 'Garota De Ipanema', 8, 1, 2, '', 285048, 9348428, 0.99),
(77, 'Enter Sandman', 9, 1, 3, 'Apocalyptica', 221701, 7286305, 0.99),
(78, 'Master Of Puppets', 9, 1, 3, 'Apocalyptica', 436453, 14375310, 0.99),
(85, 'Cochise', 10, 1, 1, 'Audioslave Chris Cornell', 222380, 5339931, 0.99),
(86, 'Show Me How to Live', 10, 1, 1, 'Audioslave Chris Cornell', 277890, 6672176, 0.99),--20
(99, 'Your Time Has Come', 11, 1, 4, 'Cornell, Commerford, Morello, Wilk', 255529, 8273592, 0.99),
(100, 'Out Of Exile', 11, 1, 4, 'Cornell, Commerford, Morello, Wilk', 291291, 9506571, 0.99 ),
(111, 'Money', 12, 1, 5, 'Berry Gordy, Jr. Janie Bradford', 147591, 2365897, 0.99),
(112, 'Long Tall Sally', 12, 1, 5, 'Enotris Johnson Little Richard Robert "Bumps" Blackwell', 106396, 1707084, 0.99),
(123, 'Quadrant', 13, 1, 2, 'Billy Cobham', 261851, 8538199, 0.99),
(124, 'Snoopy''s search-Red baron', 13, 1, 2, 'Billy Cobham', 456071, 15075616, 0.99),
(131, 'Intro/ Low Down', 14, 1, 3, '', 323683, 10642901, 0.99),
(132, '13 Years Of Grief', 14, 1, 3, '', 246987, 8137421, 0.99),
(144, 'Heart Of Gold', 15, 1, 3, '', 194873, 6417460, 0.99),
(145, 'Snowblind', 15, 1, 3, '', 420022, 13842549, 0.99),--30
(149, 'Black Sabbath', 16, 1, 3, '', 382066, 12440200, 0.99),
(150, 'The Wizard', 16, 1, 3, '', 264829, 8646737, 0.99),
(156, 'Wheels Of Confusion   The Straightener', 17, 1, 3, 'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 494524, 16065830, 0.99),
(157, 'Tomorrow''s Dream', 17, 1, 3, 'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 192496, 6252071, 0.99),
(403, 'Bumbo Da Mangueira', 34, 1, 7, 'Various', 270158, 9073350, 0.99),
(404, 'Mr Funk Samba', 34, 1, 7, 'Various', 213890, 7102545, 0.99),
(3389, 'Revelations', 271, 2, 23, '', 252376, 4111051, 0.99),
(3390, 'One and the Same', 271, 2, 23, '', 217732, 3559040, 0.99);