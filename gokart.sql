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
        class           VARCHAR(20) NOT NULL)

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

-- Race Result weak entity
DROP TABLE Maintenance;
CREATE TABLE Maintenance
    (   work_id         INT,
        kart_num        INT,
        mech_id         INT,
        hours           INT NOT NULL,
        date            TEXT NOT NULL,
        PRIMARY KEY (work_id, kart_num, mech_id),
        FOREIGN KEY (kart_num) REFERENCES Go_Kart(kart_num),
        FOREIGN KEY (mech_id) REFERENCES Mechanic(mech_id))

-- Race Result weak entity
DROP TABLE Race_Result
CREATE TABLE Race_Result
    (   driver_id       INT
        race_id         INT
        start_pos       INT NOT NULL,
        finish_pos      INT NOT NULL,
        PRIMARY KEY (driver_id, race_id),
        FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
        FOREIGN KEY (race_id) REFERENCES Driver(race_id))

CREATE TABLE Race_Result
    (   driver_id       INT
        race_id         INT
        start_pos       INT NOT NULL,
        finish_pos      INT NOT NULL,
        PRIMARY KEY (driver_id, race_id),
        FOREIGN KEY (driver_id) REFERENCES Booking(driver_id),
        FOREIGN KEY (race_id) REFERENCES Booking(race_id))