-- I. За базата от данни Movies

-- 1. Имена на актьорите мъже, участвали във филма The Usual Suspects
SELECT DISTINCT S.NAME
FROM MOVIESTAR S
JOIN STARSIN I ON S.NAME = I.STARNAME
JOIN MOVIE M ON I.MOVIETITLE = M.TITLE
WHERE M.TITLE = 'The Usual Suspects' AND S.GENDER = 'M';

-- 2. Имена на актьорите, участвали във филми от 1995, продуцирани от студио MGM
SELECT DISTINCT S.NAME
FROM MOVIESTAR S
JOIN STARSIN I ON S.NAME = I.STARNAME
JOIN MOVIE M ON I.MOVIETITLE = M.TITLE
JOIN MOVIEEXEC E ON M.PRODUCERC = E.CERT#
WHERE M.YEAR = 1995 AND E.STUDIONAME = 'MGM';

-- 3. Имена на продуцентите, които са продуцирали филми на студио MGM
SELECT DISTINCT E.NAME
FROM MOVIEEXEC E
JOIN MOVIE M ON E.CERT# = M.PRODUCERC
WHERE M.STUDIONAME = 'MGM';

-- 4. Имена на филми с дължина по-голяма от филма Star Wars
SELECT M.TITLE
FROM MOVIE M
WHERE M.LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars');

-- 5. Имена на продуцентите с нетни активи по-големи от Stephen Spielberg
SELECT DISTINCT E.NAME
FROM MOVIEEXEC E
WHERE E.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Stephen Spielberg');

-- 6. Имена на филми, продуцирани от продуценти с нетни активи по-големи от Stephen Spielberg
SELECT M.TITLE
FROM MOVIE M
JOIN MOVIEEXEC E ON M.PRODUCERC = E.CERT#
WHERE E.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Stephen Spielberg');

-- II. За базата от данни PC

-- 1. Производителя и честотата на лаптопите с размер на диска поне 9 GB
SELECT P.MAKER, L.SPEED
FROM PRODUCT P
JOIN LAPTOP L ON P.MODEL = L.MODEL
WHERE L.HD >= 9;

-- 2. Модел и цена на продуктите, произведени от производител с име B
SELECT P.MODEL, P.PRICE
FROM PRODUCT P
WHERE P.MAKER = 'B';

-- 3. Производителите, които произвеждат лаптопи, но не произвеждат персонални компютри
SELECT DISTINCT L.MAKER
FROM LAPTOP L
LEFT JOIN PC C ON L.MAKER = C.MAKER
WHERE C.MAKER IS NULL;

-- 4. Размерите на дисковете, предлагани в поне два различни персонални компютъра
SELECT HD
FROM PC
GROUP BY HD
HAVING COUNT(DISTINCT CODE) >= 2;

-- 5. Двойки модели на персонални компютри с еднаква честота и памет
SELECT P1.MODEL, P2.MODEL
FROM PC P1, PC P2
WHERE P1.SPEED = P2.SPEED AND P1.RAM = P2.RAM AND P1.CODE < P2.CODE;

-- 6. Производителите на поне два различни персонални компютри с честота поне 400
SELECT MAKER
FROM PC
GROUP BY MAKER
HAVING COUNT(DISTINCT CODE) >= 2 AND MIN(SPEED) >= 400;

-- III. За базата от данни SHIPS

-- 1. Името на корабите с водоизместимост над 50000
SELECT NAME
FROM SHIPS
WHERE DISPLACEMENT > 50000;

-- 2. Имена, водоизместимост и брой оръдия на корабите, участвали в битката при Guadalcanal
SELECT SH.NAME AS shipName, SH.DISPLACEMENT, CL.NUMGUNS
FROM SHIPS SH
JOIN CLASSES CL ON SH.CLASS = CL.CLASS
JOIN OUTCOMES O ON SH.NAME = O.SHIP
JOIN BATTLES B ON O.BATTLE = B.NAME
WHERE B.NAME = 'Guadalcanal';

-- 3. Имена на държавите с бойни кораби и бойни крайцери
SELECT DISTINCT S.COUNTRY
FROM CLASSES S, CLASSES C
WHERE S.TYPE = 'bb' AND C.TYPE = 'bc' AND S.COUNTRY = C.COUNTRY;

-- 4. Имена на корабите, които са били повредени в една битка и по-късно са участвали в друга битка
SELECT O1.SHIP AS shipName
FROM OUTCOMES O1, OUTCOMES O2
WHERE O1.SHIP = O2.SHIP AND O1.RESULT = 'damaged' AND O2.RESULT = 'sunk' AND O1.BATTLE != O2.BATTLE;
