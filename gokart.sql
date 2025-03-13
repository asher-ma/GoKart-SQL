-- Asher Mangel
-- Rental Go Kart League

-- Driver entity
DROP TABLE Driver;
CREATE TABLE Driver
    (   driver_id       INT NOT NULL PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL,
        rating          INT)

-- Race entity
DROP TABLE Race;
CREATE TABLE Race
    (   race_id         INT NOT NULL PRIMARY KEY,
        date            TEXT NOT NULL,
        track           VARCHAR(20) NOT NULL)

-- Go Kart entity
DROP TABLE Go_Kart;
CREATE TABLE Go_Kart
    (   kart_num        INT NOT NULL PRIMARY KEY,
        class           VARCHAR(20) NOT NULL)

-- Booking entity
DROP TABLE Booking;
CREATE TABLE Booking
    (   booking_id      INT NOT NULL PRIMARY KEY,
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
    (   mech_id         INT NOT NULL PRIMARY KEY,
        fname           VARCHAR(20) NOT NULL,
        lname           VARCHAR(20) NOT NULL)