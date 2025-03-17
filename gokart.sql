-- Asher Mangel
-- Rental Go Kart League

CREATE DATABASE IF NOT EXISTS Go_Kart_League;
USE Go_Kart_League;

DROP TABLE IF EXISTS Race_Result;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Race;
DROP TABLE IF EXISTS Go_Kart;
DROP TABLE IF EXISTS Mechanic;

-- Driver entity
CREATE TABLE Driver
    (   driver_id       INT PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL,
        rating          INT);

-- Race entity
CREATE TABLE Race
    (   race_id         INT PRIMARY KEY,
        date            TEXT NOT NULL,
        track           VARCHAR(20) NOT NULL);

-- Go Kart entity
CREATE TABLE Go_Kart
    (   kart_num        INT PRIMARY KEY,
        class           INT NOT NULL);

-- Booking entity
CREATE TABLE Booking
    (   booking_id      INT PRIMARY KEY,
        date            TEXT NOT NULL,
        driver_id       INT NOT NULL,
        race_id         INT NOT NULL,
        kart_num        INT NOT NULL,
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (race_id) REFERENCES Race(race_id),
        FOREIGN KEY (kart_num) REFERENCES Go_Kart(kart_num));

-- Mechanic entity
CREATE TABLE Mechanic
    (   mech_id         INT PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL);

-- Maintenance entity
CREATE TABLE Maintenance
    (   work_id         INT PRIMARY KEY,
        kart_num        INT,
        mech_id         INT,
        hours           INT NOT NULL,
        date            TEXT NOT NULL,
        FOREIGN KEY (kart_num) REFERENCES Go_Kart(kart_num),
        FOREIGN KEY (mech_id) REFERENCES Mechanic(mech_id));

-- Race Result weak entity
CREATE TABLE Race_Result
    (   driver_id       INT,
        race_id         INT,
        start_pos       INT NOT NULL,
        finish_pos      INT NOT NULL,
        PRIMARY KEY (driver_id, race_id),
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (race_id) REFERENCES Race(race_id));



-- Sample data:
-- Used data from formula1.com

-- Sample drivers:
INSERT INTO Driver (driver_id, fname, lname, rating)
VALUES
    (55, 'Carlos', 'Sainz', 2100),
    (44, 'Lewis', 'Hamilton', 2600),
    (82, 'Asher', 'Mangel', 300),
    (10, 'David', 'Coulthard', 1400),
    (1, 'Max', 'Verstappen', 3000),
    (4, 'Lando', 'Norris', 2800);

-- Sample races
INSERT INTO Race (race_id, date, track)
VALUES
    (1, '2025-03-16', 'Albert Park Circuit'),
    (3, '2024-03-23', 'Albert Park Circuit'),
    (12, '2024-07-07', 'Silverstone Circuit'),
    (50, '2024-12-20', 'K1 Speed Bellevue'),
    (51, '2024-12-20', 'K1 Speed Bellevue'),
    (2, '2025-03-23', 'Shanghai International Circuit');

-- Sample karts
INSERT INTO Go_Kart (kart_num, class)
VALUES
    (55, 1),
    (44, 1),
    (82, 5),
    (10, 2),
    (1, 1),
    (4, 1);

-- Sample bookings
INSERT INTO Booking (booking_id, date, driver_id, race_id, kart_num)
VALUES
    (0, '2025-03-13', 1, 1, 1),
    (1, '2024-03-20', 55, 3, 55),
    (2, '2024-07-04', 44, 12, 44),
    (3, '2025-03-13', 44, 1, 44),
    (4, '2025-03-16', 1, 2, 1),
    (5, '2024-12-20', 82, 50, 82),
    (6, '2024-12-20', 82, 51, 82),
    (7, '2025-03-13', 4, 1, 4);

-- Sample mechanics
INSERT INTO Mechanic (mech_id, fname, lname)
VALUES
    (0, 'Frank', 'Williams'),
    (1, 'Wesley', 'Proudlove'),
    (2, 'Jos', 'Verstappen'),
    (3, 'Kaj', 'Larsen'),
    (4, 'Enzo', 'Ferrari');

-- Sample maintenance
INSERT INTO Maintenance (work_id, kart_num, mech_id, hours, date)
VALUES
    (0, 55, 0, 12, '2025-03-12'),
    (1, 1, 2, 1, '2025-03-12'),
    (2, 82, 1, 3, '2024-12-15'),
    (3, 44, 4, 2, '2025-03-12'),
    (4, 55, 4, 4, '2024-03-22');

-- Sample race results
INSERT INTO Race_Result (driver_id, race_id, start_pos, finish_pos)
VALUES
    (55, 3, 2, 1),
    (44, 12, 2, 1),
    (1, 1, 3, 2),
    (4, 1, 1, 1),
    (44, 1, 8, 10),
    (82, 50, 4, 1),
    (82, 51, 8, 12);



-- Sample data queries
/*
I tried to use \G to better space out the columns but it just made every entry
take up a lot of space and this way is printing them including headers anyway
*/

SELECT *
FROM Driver
LIMIT 5;

SELECT *
FROM Race
LIMIT 5;

SELECT *
FROM Go_Kart
LIMIT 5;

SELECT *
FROM Booking
LIMIT 5;

SELECT *
FROM Mechanic
LIMIT 5;

SELECT *
FROM Maintenance
LIMIT 5;

SELECT *
FROM Race_Result
LIMIT 5;


-- Sample transactions

-- Select all races with competing drivers with average ratings above 2000 
SELECT 'High rated races:' AS '';
SELECT DISTINCT R.track, AVG(D.rating) AS avg_rating
FROM Race AS R
JOIN Booking AS B ON R.race_id = B.race_id
JOIN Driver AS D ON B.driver_id = D.driver_id
GROUP BY R.track
HAVING AVG(D.rating) > 2000
LIMIT 5;

-- Select all drivers names that have raced the most with class 1 karts
SELECT 'Most experienced class 1 Drivers:' AS '';

SELECT DISTINCT D.fname, D.lname, COUNT(*) AS num_races
FROM Driver AS D
JOIN Booking AS B ON D.driver_id = B.driver_id
JOIN Go_Kart AS K ON B.kart_num = K.kart_num
WHERE K.class = 1
GROUP BY D.fname, D.lname
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Select each track and group with each driver that has won at that track
SELECT 'Race Winners:' AS '';

SELECT DISTINCT R.track, D.fname, D.lname
FROM Driver AS D
JOIN Race_Result AS RR ON D.driver_id = RR.driver_id
JOIN Race AS R ON RR.race_id = R.race_id
WHERE RR.finish_pos = 1
GROUP BY R.track, D.fname
LIMIT 5;

-- Select the names of drivers that have lost the most 
SELECT 'Drivers who have lost the most places:' AS '';

SELECT DISTINCT D.fname, D.lname, (RR.start_pos - RR.finish_pos) AS pos_lost
FROM Driver AS D
JOIN Race_Result AS RR ON D.driver_id = RR.driver_id
WHERE RR.finish_pos < RR.start_pos
GROUP BY D.fname, D.lname
ORDER BY pos_lost DESC
LIMIT 5;

-- Select the names of mechanics in order by the average rating of their drivers
SELECT 'High level mechanics' AS '';

SELECT DISTINCT M.fname, M.lname
FROM Mechanic AS M
JOIN Maintenance AS MW ON M.mech_id = MW.mech_id
JOIN Booking AS B ON MW.kart_num = B.kart_num
JOIN Driver AS D ON B.driver_id = D.driver_id
GROUP BY M.fname, M.lname
ORDER BY AVG(D.rating) DESC
LIMIT 5;