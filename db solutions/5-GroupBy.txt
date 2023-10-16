-- I. За базата от данни PC
-- 1. Средна честота на персоналните компютри
SELECT AVG(SPEED) AS "Средна Честота на PC"
FROM PC;

-- 2. Среден размер на екраните на лаптопите за всеки производител
SELECT MANUFACTURER, AVG(SCREEN) AS "Среден Размер на Екран (инча)"
FROM LAPTOP
GROUP BY MANUFACTURER;

-- 3. Средна честота на лаптопите с цена над 1000
SELECT AVG(SPEED) AS "Средна Честота на Лаптопите"
FROM LAPTOP
WHERE PRICE > 1000;

-- 4. Средна цена на персоналните компютри от производител 'A'
SELECT AVG(PRICE) AS "Средна Цена на PC (Производител A)"
FROM PC
WHERE MANUFACTURER = 'A';

-- 5. Средна цена на персоналните компютри и лаптопите за производител 'B'
SELECT 'PC' AS "Тип", AVG(PRICE) AS "Средна Цена"
FROM PC
WHERE MANUFACTURER = 'B'
UNION
SELECT 'Laptop' AS "Тип", AVG(PRICE) AS "Средна Цена"
FROM LAPTOP
WHERE MANUFACTURER = 'B';

-- 6. Средна цена на персоналните компютри според честотата
SELECT SPEED, AVG(PRICE) AS "Средна Цена"
FROM PC
GROUP BY SPEED
HAVING SPEED > 800;

-- 7. Производители, които са произвели поне 3 различни персонални компютри
SELECT MANUFACTURER
FROM PC
GROUP BY MANUFACTURER
HAVING COUNT(DISTINCT CODE) >= 3;

-- 8. Производител с най-висока цена на персонален компютър
SELECT MANUFACTURER, MAX(PRICE) AS "Най-Висока Цена"
FROM PC;

-- 9. Средна цена на персоналните компютри за всяка честота по-голяма от 800
SELECT SPEED, AVG(PRICE) AS "Средна Цена"
FROM PC
GROUP BY SPEED
HAVING SPEED > 800;

-- 10. Среден размер на диска на персоналните компютри за производители, които произвеждат и принтери
SELECT P.MANUFACTURER, AVG(P.HD) AS "Среден Размер на Диска"
FROM PC P
JOIN PRINTER PR ON P.MANUFACTURER = PR.MANUFACTURER
GROUP BY P.MANUFACTURER;

-- II. За базата от данни SHIPS
-- 1. Брой на класовете бойни кораби
SELECT COUNT(DISTINCT CLASS) AS "Брой на Класовете Бойни Кораби"
FROM CLASSES;

-- 2. Среден брой оръдия за всеки клас боен кораб
SELECT S.CLASS, AVG(C.NUMGUNS) AS "Среден Брой Оръдия"
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
GROUP BY S.CLASS;

-- 3. Среден брой оръдия за всички бойни кораби
SELECT AVG(C.NUMGUNS) AS "Среден Брой Оръдия"
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS;

-- 4. Първа и последна година на пускане на вода за всеки клас боен кораб
SELECT C.CLASS, MIN(S.LAUNCHED) AS "Първа Година", MAX(S.LAUNCHED) AS "Последна Година"
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
GROUP BY C.CLASS;

-- 5. Брой на корабите, потънали в битка според класа
SELECT C.CLASS, COUNT(S.NAME) AS "Брой на Потънал
