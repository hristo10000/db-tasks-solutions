-- Модификации в базата данни Movies

-- Задача 1: Вмъкване на информация за актрисата Nicole Kidman.
INSERT INTO Actors (first_name, last_name, gender, birthdate)
VALUES ('Nicole', 'Kidman', 'жена', '1967-06-20');

-- Задача 2: Изтриване на продуценти с нетни активи под 30 милиона.
DELETE FROM Producers
WHERE net_worth < 30000000;

-- Задача 3: Изтриване на информацията за актьорите, за които не се знае адреса.
DELETE FROM MovieStars
WHERE address IS NULL;

-- Модификации в базата данни PC

-- Задача 4: Вмъкване на информация за нов модел компютър 1100, произведен от производителя C.
INSERT INTO PC (code, model, speed, ram, hd, cd, price)
VALUES (12, '1100', 2400, 2048, 500, '52x', 299);

-- Задача 5: Изтриване на информацията за компютрите с модел 1100.
DELETE FROM PC
WHERE model = '1100';

-- Задача 6: Изтриване на всички лаптопи, направени от производители, които не произвеждат принтери.
DELETE FROM Laptop
WHERE model IN (SELECT DISTINCT model FROM Printer);

-- Задача 7: Производител A придобива производител B. Обновяване на продуктите от B да бъдат с производител A.
UPDATE PC
SET maker = 'A'
WHERE maker = 'B';
UPDATE Laptop
SET maker = 'A'
WHERE maker = 'B';
UPDATE Printer
SET maker = 'A'
WHERE maker = 'B';

-- Задача 8: Намаляване наполовина на цената и добавяне на 20 GB към всеки твърд диск на компютрите.
UPDATE PC
SET price = price / 2, hd = hd + 20;

-- Задача 9: Увеличаване на размера на екрана с един инч за всеки лаптоп на производител B.
UPDATE Laptop
SET screen = screen + 1
WHERE model IN (SELECT model FROM Laptop WHERE maker = 'B');

-- Модификации в базата данни Ships

-- Задача 10: Добавяне на информация за британските бойни кораби Nelson и Rodney към таблицата Ships.
INSERT INTO Ships (name, class, launched, bore, displacement)
VALUES ('Nelson', 'Nelson', 1927, 16, 34000),
       ('Rodney', 'Nelson', 1927, 16, 34000);

-- Задача 11: Изтриване на всички кораби, които са потънали в битка.
DELETE FROM Ships
WHERE name IN (SELECT ship FROM Outcomes WHERE result = 'sunk');

-- Задача 12: Обновяване на данните в таблицата Classes, като се измерва калибърът в сантиметри и водоизместимостта в метрични тонове.
UPDATE Classes
SET bore = bore * 2.5, displacement = displacement * 1.1;
