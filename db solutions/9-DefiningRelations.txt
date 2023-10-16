-- Задача 1:

-- Дефиниране на релацията Product
CREATE TABLE Product (
    maker CHAR(1),
    model CHAR(4),
    type VARCHAR(7)
);

-- Дефиниране на релацията Printer
CREATE TABLE Printer (
    code INT,
    model CHAR(4),
    price DECIMAL(8,2),
    type VARCHAR(6),
    color CHAR(1) DEFAULT 'n'
);

-- Примерни данни за релацията Product
INSERT INTO Product (maker, model, type)
VALUES
    ('A', '1000', 'Laser'),
    ('B', '2000', 'Inkjet'),
    ('C', '3000', 'Matrix'),
    ('D', '4000', 'Laser');

-- Примерни данни за релацията Printer
INSERT INTO Printer (code, model, price, type, color)
VALUES
    (1, '1001', 199.99, 'Laser', 'y'),
    (2, '2002', 129.95, 'Inkjet', 'n'),
    (3, '3003', 99.99, 'Matrix', 'n'),
    (4, '4004', 299.99, 'Laser', 'y');

-- Добавяне на нови атрибути към релацията Printer
ALTER TABLE Printer
ADD type VARCHAR(6),
ADD color CHAR(1) DEFAULT 'n';

-- Заявка за премахване на атрибута price от релацията Printer
ALTER TABLE Printer
DROP COLUMN price;

-- Изтриване на релациите
DROP TABLE Product;
DROP TABLE Printer;

-- Задача 2:

-- Дефиниране на релациите:

-- Релацията Users
CREATE TABLE Users (
    id INT PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    registration_date DATE
);

-- Релацията Friends
CREATE TABLE Friends (
    user_id1 INT,
    user_id2 INT,
    PRIMARY KEY (user_id1, user_id2)
);

-- Релацията Walls
CREATE TABLE Walls (
    user_id INT,
    author_id INT,
    message_text TEXT,
    message_date DATE
);

-- Релацията Groups
CREATE TABLE Groups (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(255),
    description TEXT
);

-- Релацията GroupMembers
CREATE TABLE GroupMembers (
    group_id INT,
    user_id INT,
    PRIMARY KEY (group_id, user_id)
);

-- Примерни данни за релацията Users
INSERT INTO Users (id, email, password, registration_date)
VALUES
    (1, 'user1@example.com', 'password1', '2023-01-15'),
    (2, 'user2@example.com', 'password2', '2023-01-20'),
    (3, 'user3@example.com', 'password3', '2023-01-25');

-- Примерни данни за релацията Friends
INSERT INTO Friends (user_id1, user_id2)
VALUES
    (1, 2),
    (1, 3),
    (2, 3);

-- Примерни данни за релацията Walls
INSERT INTO Walls (user_id, author_id, message_text, message_date)
VALUES
    (1, 2, 'Здравей, как си?', '2023-02-01'),
    (2, 1, 'Здравей! Добре съм, благодаря!', '2023-02-02'),
    (1, 3, 'Здравейте!', '2023-02-03');

-- Примерни данни за релацията Groups
INSERT INTO Groups (group_id, group_name, description)
VALUES
    (1, 'Group 1', 'Първа група за споделяне на снимки'),
    (2, 'Group 2', 'Втора група за обмен на съвети');

-- Примерни данни за релацията GroupMembers
INSERT INTO GroupMembers (group_id, user_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 2),
    (2, 3);
