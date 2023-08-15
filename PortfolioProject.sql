SELECT*
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4


SELECT  Location,date,total_cases,new_cases,total_deaths,population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--Looking at Total cases vs Total Deaths

SELECT  Location,date,total_cases,total_deaths,(total_deaths/total_cases

)*100 AS DEATHPRECENTAGE
FROM PortfolioProject..CovidDeaths
WHERE [location] LIKE '%states%'
ORDER BY 1,2

-- Looking at total cases vs total population
--shows what percentag of population got Covid
SELECT  Location,date,population,total_cases,(total_cases/population)*100 AS PercentPopulationinfected
FROM PortfolioProject..CovidDeaths
WHERE [location] LIKE '%states%'
ORDER BY 1,2


--Looking at Counytries with Highest Infection Rate Compared to Population
SELECT  Location,population,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 AS PercentPopulationinfected
FROM PortfolioProject..CovidDeaths
GROUP BY [location],population 
ORDER BY PercentPopulationinfected DESC

-- Showing Countries with Highest Death Count Per Population
SELECT  Location,MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY [location]
ORDER BY TotalDeathCount DESC

--let's Break Things Down BY Continent
SELECT  continent,MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like 'india'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL NUMBERS
SELECT  date,SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS INT)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY [date]
ORDER BY 1,2

--across the world
SELECT  SUM(new_cases) AS total_cases,SUM(CAST(new_deaths AS INT)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- looking at tootral poipulation vs vaccination
SELECT dea.continent,dea.[location],dea.[date],dea.[population],vac.continent
FROM  PortfolioProject..CovidDeaths  AS dea
JOIN PortfolioProject..CovidVaccinations AS vac
ON dea.[location]=vac.[location] and dea.[date]=vac.[date]
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

