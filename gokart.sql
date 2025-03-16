-- Asher Mangel
-- Rental Go Kart League

-- Driver entity
DROP TABLE Driver;
CREATE TABLE Driver
    (   driver_id       INT PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL,
        rating          INT)

-- Race entity
DROP TABLE Race;
CREATE TABLE Race
    (   race_id         INT PRIMARY KEY,
        date            TEXT NOT NULL,
        track           VARCHAR(20) NOT NULL)

-- Go Kart entity
DROP TABLE Go_Kart;
CREATE TABLE Go_Kart
    (   kart_num        INT PRIMARY KEY,
        class           INT NOT NULL)

-- Booking entity
DROP TABLE Booking;
CREATE TABLE Booking
    (   booking_id      INT PRIMARY KEY,
        date            TEXT NOT NULL,
        driver_id       INT NOT NULL,
        race_id         INT NOT NULL,
        kart_num        INT NOT NULL,
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (race_id) REFERENCES Race(race_id),
        FOREIGN KEY (kart_num) REFERENCES Go_Kart(kart_num))

-- Mechanic entity
DROP TABLE Mechanic;
CREATE TABLE Mechanic
    (   mech_id         INT PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL)

-- Maintenance entity
DROP TABLE Maintenance;
CREATE TABLE Maintenance
    (   work_id         INT PRIMARY KEY,
        kart_num        INT,
        mech_id         INT,
        hours           INT NOT NULL,
        date            TEXT NOT NULL,
        FOREIGN KEY (kart_num) REFERENCES Go_Kart(kart_num),
        FOREIGN KEY (mech_id) REFERENCES Mechanic(mech_id))

-- Race Result weak entity
DROP TABLE Race_Result;
CREATE TABLE Race_Result
    (   driver_id       INT,
        race_id         INT,
        start_pos       INT NOT NULL,
        finish_pos      INT NOT NULL,
        PRIMARY KEY (driver_id, race_id),
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (race_id) REFERENCES Race(race_id))



-- Sample data:
-- Used data from formula1.com

-- Sample drivers:
INSERT INTO Driver (driver_id, fname, lname, rating)
VALUES
    (55, 'Carlos', 'Sainz', 2100),
    (44, 'Lewis', 'Hamilton', 2600),
    (82, 'Asher', 'Mangel', 300),
    (10, 'David', 'Coulthard', 1400),
    (1, 'Max', 'Verstappen', 3000);

-- Sample races
INSERT INTO Race (race_id, date, track)
VALUES
    (1, '2025-03-16', 'Melbourne Grand Prix Circuit'),
    (3, '2024-03-23', 'Melbourne Grand Prix Circuit'),
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
    (1, 1);

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
    (44, 1, 8, 10),
    (82, 50, 4, 2)
    (82, 51, 8, 12);



-- Sample data queries
SELECT *
FROM Driver
LIMIT 5\G;

SELECT *
FROM Race
LIMIT 5\G;

SELECT *
FROM Go_Kart
LIMIT 5\G;

SELECT *
FROM Booking
LIMIT 5\G;

SELECT *
FROM Mechanic
LIMIT 5\G;

SELECT *
FROM Maintenance
LIMIT 5\G;

SELECT *
FROM Race_Result
LIMIT 5\G;


/*
-- Sample transactions

-- Select all races with a competing driver that has a rating above 2000 
SELECT DISTINCT R.track
FROM Race AS R
JOIN Booking AS B ON R.race_id = B.race_id
JOIN Driver AS D ON B.driver_id = D.driver_id
WHERE D.rating > 2000
LIMIT 5\G;

-- Select all drivers names that have raced with karts in class 1
SELECT D.fname, D.lname
FROM Driver AS D
JOIN Booking AS B ON D.

-- Select the name of drivers that have finished first


-- Select the names of drivers that have finished in a lower position than where they started 


-- Select the names of mechanics who have worked a kart drived by a driver with a rating above 2000
*/