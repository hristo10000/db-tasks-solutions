-- I. За базата от данни Movies

-- 1. Адрес на студио 'Disney'
SELECT ADDRESS FROM STUDIO WHERE NAME = 'Disney';

-- 2. Рождена дата на актьора Jack Nicholson
SELECT BIRTHDATE FROM MOVIESTAR WHERE NAME = 'Jack Nicholson';

-- 3. Имена на актьорите във филм от 1980 или с думата 'Knight' в заглавието
SELECT STARNAME FROM STARSIN WHERE MOVIEYEAR = 1980 OR MOVIETITLE LIKE '%Knight%';

-- 4. Имена на продуцентите с нетни активи над 10 000 000 долара
SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 10000000;

-- 5. Имена на актьорите, които са мъже или живеят на Prefect Rd
SELECT NAME FROM MOVIESTAR WHERE GENDER = 'M' OR ADDRESS = 'Prefect Rd';

-- II. За базата от данни PC

-- 1. Модел, честота и размер на диска (с псевдоними MHz и GB) за PC-та под 1200 долара
SELECT MODEL, SPEED AS MHz, HD AS GB FROM PC WHERE PRICE < 1200;

-- 2. Производителите на принтери без повторения
SELECT DISTINCT MAKER FROM PRODUCT WHERE TYPE = 'Printer';

-- 3. Модел, размер на паметта и размер на екрана за лаптопите над 1000 долара
SELECT MODEL, RAM, SCREEN FROM LAPTOP WHERE PRICE > 1000;

-- 4. Всички цветни принтери
SELECT MODEL FROM PRINTER WHERE COLOR = 'y';

-- 5. Модел, честота и размер на диска за PC-та с CD 12x или 16x и цена под 2000 долара
SELECT MODEL, SPEED AS MHz, HD AS GB FROM PC WHERE CD IN ('12x', '16x') AND PRICE < 2000;

-- III. За базата от данни SHIPS

-- 1. Клас и страна на класовете с по-малко от 10 оръдия
SELECT CLASS, COUNTRY FROM CLASSES WHERE NUMGUNS < 10;

-- 2. Имена на корабите, пуснати на вода преди 1918 с псевдоним shipName
SELECT NAME AS shipName FROM SHIPS WHERE LAUNCHED < 1918;

-- 3. Имена на корабите и съответните битки, в които са потънали
SELECT SH.NAME AS shipName, OUTCOME.BATTLE FROM SHIPS SH
INNER JOIN OUTCOMES ON SH.NAME = OUTCOMES.SHIP WHERE OUTCOME.RESULT = 'sunk';

-- 4. Имена на корабите, съответстващи на името на техния клас
SELECT SH.NAME AS shipName FROM SHIPS SH
INNER JOIN CLASSES ON SH.CLASS = CLASSES.CLASS WHERE SH.NAME = CLASSES.CLASS;

-- 5. Имена на корабите, които започват с 'R'
SELECT NAME AS shipName FROM SHIPS WHERE NAME LIKE 'R%';

-- 6. Имена на корабите, съдържащи 2 или повече думи
SELECT NAME AS shipName FROM SHIPS WHERE NAME LIKE '% %';
