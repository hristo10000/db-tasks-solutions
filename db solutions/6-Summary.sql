-- За базата от данни MOVIES

-- Задача 1
SELECT Title, Year
FROM Movies
WHERE (Duration > 120 OR Duration IS NULL) AND Year < 2000;

-- Задача 2
SELECT Name, Gender
FROM Actors
WHERE Name LIKE 'J%' AND BirthYear > 1948
ORDER BY Name DESC;

-- Задача 3
SELECT S.Name AS Studio, COUNT(*) AS ActorCount
FROM Studios S
JOIN MovieActors MA ON S.StudioID = MA.StudioID
GROUP BY S.Name;

-- Задача 4
SELECT A.Name AS Actor, COUNT(*) AS MovieCount
FROM Actors A
JOIN MovieActors MA ON A.ActorID = MA.ActorID
GROUP BY A.Name;

-- Задача 5
SELECT S.Name AS Studio, M.Title AS LastMovie
FROM Studios S
JOIN Movies M ON S.StudioID = M.StudioID
WHERE M.ReleaseDate = (SELECT MAX(ReleaseDate) FROM Movies WHERE StudioID = S.StudioID);

-- Задача 6
SELECT Name
FROM Actors
ORDER BY BirthYear DESC
LIMIT 1;

-- Задача 7
WITH ActorMovieCounts AS (
    SELECT ActorID, COUNT(*) AS MovieCount
    FROM MovieActors
    GROUP BY ActorID
)
SELECT A.Name AS Actor, S.Name AS Studio
FROM Actors A
JOIN MovieActors MA ON A.ActorID = MA.ActorID
JOIN Studios S ON MA.StudioID = S.StudioID
WHERE MA.ActorID IN (SELECT ActorID FROM ActorMovieCounts WHERE MovieCount = (SELECT MAX(MovieCount) FROM ActorMovieCounts))
ORDER BY A.Name;

-- Задача 8
SELECT M.Title, M.Year, COUNT(*) AS ActorCount
FROM Movies M
JOIN MovieActors MA ON M.MovieID = MA.MovieID
GROUP BY M.MovieID
HAVING ActorCount > 2;

-- За базата от данни SHIPS

-- Задача 1
SELECT DISTINCT Name
FROM Ships
WHERE (Name LIKE 'C%' OR Name LIKE 'K%')
AND EXISTS (SELECT * FROM Outcomes WHERE Outcomes.ShipName = Ships.Name);

-- Задача 2
SELECT Name, Country
FROM Ships
WHERE NOT EXISTS (SELECT * FROM Outcomes WHERE Outcomes.ShipName = Ships.Name);

-- Задача 3
WITH ShipSinks AS (
    SELECT Country, COUNT(*) AS SunkCount
    FROM Ships
    WHERE EXISTS (SELECT * FROM Outcomes WHERE Outcomes.ShipName = Ships.Name AND Outcomes.Result = 'sunk')
    GROUP BY Country
)
SELECT S.Country, COALESCE(S.SunkCount, 0) AS SunkCount
FROM (SELECT DISTINCT Country FROM Ships) S
LEFT JOIN ShipSinks ON S.Country = ShipSinks.Country;

-- Задача 4
SELECT Name
FROM Battles
WHERE NumberOfShips > (SELECT NumberOfShips FROM Battles WHERE Name = 'Guadalcanal');

-- Задача 5
SELECT Name
FROM Battles
WHERE NumberOfNations > (SELECT NumberOfNations FROM Battles WHERE Name = 'Surigao Strait');

-- Задача 6
SELECT Name
FROM Ships
WHERE Guns = (SELECT MIN(Guns) FROM Ships WHERE Guns IS NOT NULL);

-- Задача 7
WITH Repaired AS (
    SELECT ShipName
    FROM Outcomes
    WHERE Result = 'damaged' AND EXISTS (SELECT * FROM Outcomes WHERE Result = 'OK' AND ShipName = Outcomes.ShipName)
)
SELECT COUNT(*) AS RepairedCount
FROM Repaired;

-- Задача 8
WITH Repaired AS (
    SELECT ShipName
    FROM Outcomes
    WHERE Result = 'damaged' AND EXISTS (SELECT * FROM Outcomes WHERE Result = 'OK' AND ShipName = Outcomes.ShipName)
)
SELECT Outcomes.ShipName, Battles.Name AS BattleName, Battles.Date AS BattleDate
FROM Repaired
JOIN Outcomes ON Repaired.ShipName = Outcomes.ShipName
JOIN Battles ON Outcomes.BattleName = Battles.Name
ORDER BY Battles.Name;

-- За базата от данни PC

-- Задача 1
SELECT DISTINCT P1.Model
FROM PC P1
JOIN PC P2 ON P1.Model = P2.Model
WHERE P1.Screen = 15 AND P2.Screen = 11;

-- Задача 2
SELECT DISTINCT P1.Model
FROM PC P1
WHERE P1.Price < (SELECT MIN(Price) FROM Laptop);

-- Задача 3
WITH ModelAvgPrice AS (
    SELECT Model, AVG(Price) AS AvgPrice
    FROM PC
    GROUP BY Model
)
SELECT Model
FROM ModelAvgPrice
WHERE AvgPrice < (SELECT MIN(Price) FROM Laptop);

-- Задача 4
SELECT P1.Product, P1.Manufacturer, COUNT(P2.Model) AS ModelsCount
FROM PC P1
JOIN PC P2 ON P1.Product = P2.Product AND P1.Price <= P2.Price
GROUP BY P1.Product, P1.Manufacturer;

-- За базата от данни MOVIES (допълнение)

-- Задача 9
SELECT S.Studio, AVG(M.Duration) AS AverageDuration
FROM Studios S
JOIN Movies M ON S.StudioID = M.StudioID
GROUP BY S.Studio;

-- Задача 10
WITH ActorMovieCounts AS (
    SELECT ActorID, COUNT(*) AS MovieCount
    FROM MovieActors
    GROUP BY ActorID
)
SELECT A.Name AS Actor, AVG(M.Duration) AS AverageDuration
FROM Actors A
JOIN MovieActors MA ON A.ActorID = MA.ActorID
JOIN Movies M ON MA.MovieID = M.MovieID
WHERE MA.ActorID IN (SELECT ActorID FROM ActorMovieCounts WHERE MovieCount > 1)
GROUP BY A.Name;
