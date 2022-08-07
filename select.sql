-- SELECT Basics Exercises

-- Show population of Germany
SELECT population FROM world
  WHERE name = 'Germany';

-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- Show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

--
-- SELECT FROM world exercises

-- Show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- Show the name for the countries that have a population of at least 200 million.
SELECT name FROM world
WHERE population > 200000000;

-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population FROM world WHERE population > 200000000;

-- Show the name and population in millions for the countries of the continent 'South America'.
SELECT name, population/1000000 FROM world WHERE continent = 'South America';

-- Show the name and population for France, Germany, Italy.
SELECT name, population FROM world WHERE name in ('france', 'germany', 'italy');

-- Show the countries which have a name that includes the word 'United'
SELECT name FROM world WHERE name LIKE ('%united%');

-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world WHERE area > 3000000 or population > 250000000;

-- Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
SELECT name, population, area FROM world WHERE (area > 3000000 and population < 250000000) or (area < 3000000 and population > 250000000);

-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world WHERE continent = 'south america';

-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
SELECT name, ROUND(gdp/population, -3) FROM world WHERE gdp > 1000000000000;

-- Show the name and capital WHERE the name and the capital have the same number of characters.
SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital);

-- Show the name and the capital where the first letters of each match. Don't include countries WHERE the name and the capital are the same word.
SELECT name, capital
FROM world WHERE left(name,1) = left(capital,1) AND NOT (name = capital);

-- Find the country that has all the vowels and no spaces in its name.
SELECT name
   FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
  AND name NOT LIKE '% %'

--
-- Select from Nobel Tutorial

-- Display Nobel prize winners for 1950.

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

 -- Show who won the 1962 prize for literature. 
 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature';

-- Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- Give the name of the 'peace' winners since the year 2000, including 2000. 
SELECT winner
FROM nobel
WHERE yr > 1999 AND subject = 'peace';

-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive. 
SELECT *
FROM nobel
WHERE yr BETWEEN 1980 AND 1989
AND subject = 'literature';

/* Show all details of the presidential winners:

    Theodore Roosevelt
    Thomas Woodrow Wilson
    Jimmy Carter
    Barack Obama */
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

-- Show the winners with first name John 
SELECT winner
FROM nobel
WHERE winner LIKE ('John%');

-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
SELECT *
FROM nobel
WHERE (subject = 'physics' AND yr = 1980)
OR (subject = 'chemistry' AND yr = 1984);

-- Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
SELECT *
FROM nobel
WHERE yr = 1980
AND subject NOT IN ('chemistry', 'medicine');

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) 
SELECT *
FROM nobel
WHERE subject = 'medicine'
AND yr < 1910
OR subject = 'literature'
AND yr > 2003;

-- Find all details of the prize won by PETER GRÜNBERG.
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- Find all details of the prize won by EUGENE O'NEILL.
SELECT *
FROM nobel
WHERE winner = "EUGENE O'NEILL";

-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject FROM nobel WHERE winner LIKE ('Sir%') ORDER BY yr DESC;

-- The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('physics','chemistry'),subject,winner;

--
-- SELECT within SELECT Tutorial

-- List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE gdp/population >
(SELECT gdp/population FROM world WHERE name = 'United Kingdom')
AND continent = 'Europe';

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN
(SELECT continent FROM world where name = 'Argentina' OR name = 'Australia')
ORDER BY name;

-- Which country has a population that is more than United Kingom but less than Germany? Show the name and the population.
SELECT name, population
FROM world
WHERE population >
(SELECT population FROM world WHERE name = 'United Kingdom')
AND population <
(SELECT population FROM world WHERE name = 'Germany');

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp >
(SELECT MAX(gdp) FROM world WHERE continent = 'Europe');
