-- Създаване на базата данни Flights
CREATE DATABASE Flights;
USE Flights;

-- Таблица Airline
CREATE TABLE Airline (
    code CHAR(2) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

-- Таблица Airplane
CREATE TABLE Airplane (
    code CHAR(3) PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    seats INT NOT NULL,
    year INT NOT NULL
);

-- Таблица Booking
CREATE TABLE Booking (
    code VARCHAR(6) PRIMARY KEY,
    agency VARCHAR(255) NOT NULL,
    airline_code CHAR(2) NOT NULL,
    flight_number VARCHAR(10) NOT NULL,
    customer_ID INT NOT NULL,
    booking_date DATE NOT NULL,
    flight_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status INT NOT NULL
);

-- Таблица Flight
CREATE TABLE Flight (
    fnumber VARCHAR(10) PRIMARY KEY,
    airline_operator CHAR(2) NOT NULL,
    dep_airport CHAR(3) NOT NULL,
    arr_airport CHAR(3) NOT NULL,
    flight_time TIME NOT NULL,
    flight_duration INT NOT NULL,
    airplane CHAR(3) NOT NULL
);

-- Таблица Agency
CREATE TABLE Agency (
    name VARCHAR(255) PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    phone VARCHAR(15)
);

-- Таблица Customer
CREATE TABLE Customer (
    id INT PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Таблица Airport
CREATE TABLE Airport (
    code CHAR(3) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

-- Прилагане на външни ключове и ограничения
-- Външни ключове и референтна цялостност
ALTER TABLE Flight
ADD FOREIGN KEY (airline_operator) REFERENCES Airline(code);

ALTER TABLE Booking
ADD FOREIGN KEY (airline_code) REFERENCES Airline(code);

ALTER TABLE Booking
ADD FOREIGN KEY (flight_number) REFERENCES Flight(fnumber);

ALTER TABLE Booking
ADD FOREIGN KEY (customer_ID) REFERENCES Customer(id);

ALTER TABLE Flight
ADD FOREIGN KEY (dep_airport) REFERENCES Airport(code);

ALTER TABLE Flight
ADD FOREIGN KEY (arr_airport) REFERENCES Airport(code);

ALTER TABLE Flight
ADD FOREIGN KEY (airplane) REFERENCES Airplane(code);

ALTER TABLE Booking
ADD FOREIGN KEY (agency) REFERENCES Agency(name);

-- NULL или NOT NULL ограничения
-- Не се изисква допълнително задаване, тъй като NOT NULL е зададен по подразбиране.

-- UNIQUE ограничения
-- Уникален код на авиокомпания
CREATE UNIQUE INDEX UQ_Airline_Name ON Airline(name);

-- Уникално име на летище в рамките на дадена държава
CREATE UNIQUE INDEX UQ_Airport_Name_Country ON Airport(name, country);

-- CHECK ограничения
-- Броят места в самолета не може да бъде по-малък или равен на нула
ALTER TABLE Airplane
ADD CONSTRAINT CK_Airplane_Seats CHECK (seats > 0);

-- Датата на полета трябва да бъде след или в деня на датата на резервация на билета
ALTER TABLE Booking
ADD CONSTRAINT CK_Booking_FlightDate CHECK (flight_date >= booking_date);

-- Проверка за валидност на email адреса на клиента
ALTER TABLE Customer
ADD CONSTRAINT CK_Customer_Email CHECK (CHARINDEX('@', email) > 0 AND CHARINDEX('.', email) > 0 AND LEN(email) >= 6);

-- Състоянието на резервацията може да бъде 0 или 1
ALTER TABLE Booking
ADD CONSTRAINT CK_Booking_Status CHECK (status IN (0, 1);
