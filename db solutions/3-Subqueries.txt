-- I. За базата от данни Movies

-- 1. Имена на актрисите, които са и продуценти с нетни активи над 10 милиона
SELECT DISTINCT A.NAME
FROM MOVIESTAR A
WHERE A.NAME IN (SELECT DISTINCT S.NAME
                FROM MOVIESTAR S
                JOIN MOVIEEXEC E ON S.NAME = E.NAME
                WHERE E.NETWORTH > 10000000);

-- 2. Имена на актьорите (мъже и жени), които не са продуценти
SELECT DISTINCT S.NAME
FROM MOVIESTAR S
WHERE S.GENDER NOT IN (SELECT DISTINCT GENDER FROM MOVIEEXEC);

-- 3. Имена на всички филми с дължина по-голяма от дължината на филма 'Star Wars'
SELECT M.TITLE
FROM MOVIE M
WHERE M.LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars');

-- 4. Имена на продуцентите и имената на филмите за всички филми, които са продуцирани от продуценти с нетни активи по-големи от тези на 'Merv Griffin'
SELECT DISTINCT E.NAME, M.TITLE
FROM MOVIEEXEC E
JOIN MOVIE M ON E.CERT# = M.PRODUCERC
WHERE E.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Merv Griffin');

-- II. За базата от данни PC

-- 1. Производителите на персонални компютри с честота над 500
SELECT DISTINCT P.MAKER
FROM PC P
WHERE P.SPEED > 500;

-- 2. Код, модел и цена на принтерите с най-висока цена
SELECT P.CODE, P.MODEL, P.PRICE
FROM PRINTER P
WHERE P.PRICE = (SELECT MAX(PRICE) FROM PRINTER);

-- 3. Лаптопите, чиято честота е по-ниска от честотата на всички персонални компютри
SELECT L.*
FROM LAPTOP L
WHERE L.SPEED < ALL (SELECT P.SPEED FROM PC P);

-- 4. Модела и цената на продукта (PC, лаптоп или принтер) с най-висока цена
SELECT P.MODEL, P.PRICE
FROM (SELECT MODEL, PRICE FROM PC
      UNION ALL
      SELECT MODEL, PRICE FROM LAPTOP
      UNION ALL
      SELECT MODEL, PRICE FROM PRINTER) P
WHERE P.PRICE = (SELECT MAX(PRICE) FROM (SELECT PRICE FROM PC
                                         UNION ALL
                                         SELECT PRICE FROM LAPTOP
                                         UNION ALL
                                         SELECT PRICE FROM PRINTER));

-- 5. Производителя на цветния принтер с най-ниска цена
SELECT P.MAKER
FROM PRINTER P
WHERE P.COLOR = 'y' AND P.PRICE = (SELECT MIN(PRICE) FROM PRINTER WHERE COLOR = 'y');

-- 6. Производителите на персонални компютри с най-малко RAM памет и най-бързи процесори
SELECT DISTINCT P.MAKER
FROM PC P
WHERE P.RAM = (SELECT MIN(RAM) FROM PC) AND P.SPEED = (SELECT MAX(SPEED) FROM PC);

-- III. За базата от данни SHIPS

-- 1. Страните, чиито кораби са с най-голям брой оръдия
SELECT DISTINCT S.COUNTRY
FROM CLASSES S
WHERE S.NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES);

-- 2. Класовете, за които поне един от корабите е потънал в битка
SELECT DISTINCT C.CLASS
FROM SHIPS S
JOIN OUTCOMES O ON S.NAME = O.SHIP
JOIN BATTLES B ON O.BATTLE = B.NAME
JOIN CLASSES C ON S.CLASS = C.CLASS
WHERE O.RESULT = 'sunk';

-- 3. Името и класа на корабите с 16 инчови оръдия
SELECT S.NAME, S.CLASS
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
WHERE C.BORE = 16;

-- 4. Имена на битките, в които са участвали кораби от клас 'Kongo'
SELECT DISTINCT B.NAME
FROM BATTLES B
JOIN OUTCOMES O ON B.NAME = O.BATTLE
JOIN SHIPS S ON O.SHIP = S.NAME
JOIN CLASSES C ON S.CLASS = C.CLASS
WHERE C.CLASS = 'Kongo';

-- 5. Класа и името на корабите, чиито брой оръдия е по-голям или равен на този на корабите със същия калибър оръдия
SELECT S.CLASS, S.NAME
FROM SHIPS S
WHERE S.NUMGUNS >= ALL (SELECT NUMGUNS FROM SHIPS WHERE CLASS = S.CLASS);
