-- I. За базата от данни Movies

-- 1. Името на продуцента и имената на филмите, продуцирани от продуцента на филма 'Star Wars'
SELECT E.NAME, M.TITLE
FROM MOVIE M
JOIN MOVIEEXEC E ON M.PRODUCERC = E.CERT#
WHERE M.TITLE = 'Star Wars';

-- 2. Имената на продуцентите на филмите, в които е участвал 'Harrison Ford'
SELECT DISTINCT E.NAME
FROM MOVIE M
JOIN CASTS C ON M.TITLE = C.MOVIE
JOIN MOVIEEXEC E ON M.PRODUCERC = E.CERT#
WHERE C.ACTOR = 'Harrison Ford';

-- 3. Името на студиото и имената на актьорите, участвали във филми, произведени от това студио, подредени по име на студио
SELECT S.NAME, C.NAME
FROM STUDIOS S
JOIN MOVIE M ON S.NAME = M.STUDIO
JOIN CASTS C ON M.TITLE = C.MOVIE
ORDER BY S.NAME;

-- 4. Имената на актьорите, участвали във филми на продуценти с най-големи нетни активи
SELECT DISTINCT M.NAME
FROM MOVIEEXEC M
JOIN CASTS C ON M.CERT# = C.ACTOR
WHERE M.NETWORTH = (SELECT MAX(NETWORTH) FROM MOVIEEXEC);

-- 5. Имената на актьорите, които не са участвали в нито един филм
SELECT DISTINCT M.NAME
FROM MOVIESTAR M
LEFT JOIN CASTS C ON M.NAME = C.ACTOR
WHERE C.MOVIE IS NULL;

-- II. За базата от данни PC

-- 1. Производител, модел и тип на продукт за тези производители, за които съответният продукт не се продава
SELECT M.MAKER, P.MODEL, 'PC' AS TYPE
FROM (SELECT DISTINCT MAKER FROM PC
      UNION
      SELECT DISTINCT MAKER FROM LAPTOP
      UNION
      SELECT DISTINCT MAKER FROM PRINTER) M
LEFT JOIN PC P ON M.MAKER = P.MAKER
WHERE P.MODEL IS NULL
UNION
SELECT M.MAKER, L.MODEL, 'Laptop' AS TYPE
FROM (SELECT DISTINCT MAKER FROM PC
      UNION
      SELECT DISTINCT MAKER FROM LAPTOP
      UNION
      SELECT DISTINCT MAKER FROM PRINTER) M
LEFT JOIN LAPTOP L ON M.MAKER = L.MAKER
WHERE L.MODEL IS NULL
UNION
SELECT M.MAKER, PR.MODEL, 'Printer' AS TYPE
FROM (SELECT DISTINCT MAKER FROM PC
      UNION
      SELECT DISTINCT MAKER FROM LAPTOP
      UNION
      SELECT DISTINCT MAKER FROM PRINTER) M
LEFT JOIN PRINTER PR ON M.MAKER = PR.MAKER
WHERE PR.MODEL IS NULL;

-- 2. Всички производители, които правят както лаптопи, така и принтери
SELECT M.MAKER
FROM (SELECT DISTINCT MAKER FROM LAPTOP
      UNION
      SELECT DISTINCT MAKER FROM PRINTER) M
JOIN PC P ON M.MAKER = P.MAKER;

-- 3. Размерите на твърдите дискове, които се появяват в два или повече модела лаптопи
SELECT HD
FROM LAPTOP
GROUP BY HD
HAVING COUNT(*) >= 2;

-- 4. Всички модели персонални компютри, които нямат регистриран производител
SELECT MODEL
FROM PC
WHERE MAKER IS NULL;

-- III. За базата от данни SHIPS

-- 1. Цялата налична информация за всеки кораб, включително и данните за неговия клас, без тези класове, които нямат кораби
SELECT S.NAME, S.CLASS, S.LAUNCHED, S.COUNTRY, S.NUMGUNS, C.BORE, C.DISP
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
UNION
SELECT NULL, C.CLASS, NULL, NULL, NULL, C.BORE, C.DISP
FROM CLASSES C
WHERE C.CLASS NOT IN (SELECT CLASS FROM SHIPS);

-- 2. Информацията за корабите и класовете, които нямат кораби, но има кораби със същото име като тяхното
SELECT S.NAME, S.CLASS, S.LAUNCHED, S.COUNTRY, S.NUMGUNS, C.BORE, C.DISP
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
UNION
SELECT S.NAME, C.CLASS, S.LAUNCHED, S.COUNTRY, S.NUMGUNS, C.BORE, C.DISP
FROM CLASSES C
LEFT JOIN SHIPS S ON C.CLASS = S.CLASS;

-- 3. За всяка страна изведете имената на корабите, които никога не са участвали в битка
SELECT DISTINCT S.COUNTRY, S.NAME
FROM CLASSES S
WHERE S.NAME NOT IN (SELECT O.SHIP
                     FROM OUTCOMES O);

-- 4. Имената на всички кораби с поне 7 оръдия, пуснати на вода през 1916, като резултатната колона се нарича "Ship Name"
SELECT S.NAME AS "Ship Name", S.LAUNCHED, S.NUMGUNS
FROM SHIPS S
WHERE S.NUMGUNS >= 7 AND S.LAUNCHED = 1916;

-- 5. Името, водоизместимостта и годината на пускане на вода на всички кораби, които имат същото име като техния клас
SELECT S.NAME, C.DISP AS "Displacement", S.LAUNCHED AS "Year Launched"
FROM SHIPS S
JOIN CLASSES C ON S.CLASS = C.CLASS
WHERE S.NAME = C.CLASS;

-- 6. Всички класове кораби, от които няма пуснат на вода нито един кораб
SELECT C.CLASS
FROM CLASSES C
WHERE C.CLASS NOT IN (SELECT S.CLASS FROM SHIPS S);

-- 7. Името, водоизместимостта и броя оръдия на корабите, участвали в битката 'North Atlantic', а също и резултата от битката
SELECT S.NAME, S.DISP AS "Displacement", S.NUMGUNS, O.RESULT
FROM SHIPS S
JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.BATTLE = 'North Atlantic';

