--Create database PortfolioProject
--Drop Database PortfolioProject


--SELECT STATEMENT
	--Selecting all columns from various Table
Select *
From PortfolioProject..CovidDeaths

Select *
From PortfolioProject..Covidvaccinations


----PRACTICING SELECT STATEMENT OF SPECIFIC COLUMNS
	--Selecting specific individual columns of your preference
Select continent,location, date, population, total_cases, total_deaths, New_cases, new_deaths
From PortfolioProject..CovidDeaths


----SELECT, WHERE AND ORDER BY STATEMENT WHILE PERFOMING SOME STANDARD MATHS
	--Death Percentage of Total_cases
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
From PortfolioProject..CovidDeaths
Where location like '%Nigeria%'
Order by 1, 2

	--Looking at Infection Percentatge of Population
Select location, date, total_cases, population, (total_cases/population)*100 as 'Infection Percentage'
From PortfolioProject..CovidDeaths
--Where location like '%Nigeria%'
Order by 1, 2


--SELECT, WHERE, GROUP BY AND ORDER BY STATEMENT WHILE PERFOMING SOME STANDARD MATHS
	--Looking for Highest Infection to Population/ People who caught Covid more in ratio to their population
Select location, population, Max(total_cases) as 'Highest Infection Count', Max((total_cases/population))*100 as Percentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by location, population
Order by 4 desc

	--Highest Death Count & Percentage by Population in Descending Order by HighestinfectionCount
Select location, population, Max(total_deaths) as 'Highest Death Count', Max((total_deaths/population))*100 as 'Death Percentage'
From PortfolioProject..CovidDeaths
Where continent is not null
Group by location, population
Order by 3 desc

	--Maximum Death Count by a Country in each Continent
Select continent, Max(total_deaths) as 'Highest Death Count'
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
Order by 2 desc

	--Total Death Count by Continent
Select continent, Sum(new_deaths) as 'Total death Count'
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
Order by 2 desc

	--Looking at the data Globally for each day
Select Date, Sum(New_cases) as Total_Cases, Sum(New_Deaths) as Total_Deaths, Sum(New_Deaths)/Sum
(New_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Date
Order by 1, 2

	--Looking at the data Globally
Select Sum(New_cases) as Total_Cases,Sum(New_Deaths) as Total_Deaths,Sum(New_Deaths)/Sum
(New_cases)*100 as Death_Percentage
From PortfolioProject..CovidDeaths
Where continent is not null
--Group by Date
Order by 1, 2



--PERFOMING JOINS AND ALIASES
	--Looking at basic Joins
Select *
From PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
	On CD.Location = CV.Location
	and CD.Date = CV.Date


Select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations
, Sum(CV.new_vaccinations) Over (Partition by CD.location order by CD.location, CD.date) 'Rolling People Vaccinated'
From PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
	On CD.Location = CV.Location
	and CD.Date = CV.Date
Where CD.continent is not null
Order by 2,3



----CREATING A CTE
With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) as
(
Select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations
, Sum(CV.new_vaccinations) Over (Partition by CD.location order by CD.location, CD.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
	On CD.Location = CV.Location
	and CD.Date = CV.Date
Where CD.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100 as Percentage
From PopvsVac
Order by 2,3



----CREATING A TEMP TABLE
Drop Table If exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar (255),
Date Date,
Population Numeric,
New_Vaccinations Numeric,
RollingPeopleVaccinated Numeric,)

Insert Into #PercentPopulationVaccinated
Select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations
, Sum(CV.new_vaccinations) Over (Partition by CD.location order by CD.location, CD.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
	On CD.Location = CV.Location
	and CD.Date = CV.Date
--Where CD.location like '%states%'
--Where CD.continent is not null
--Order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 as Percentage
From #PercentPopulationVaccinated



--CREATING VIEWS
Create View PercentPopulationVaccinated as
Select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations
, Sum(CV.new_vaccinations) Over (Partition by CD.location order by 
CD.location, CD.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
	On CD.Location = CV.Location
	and CD.Date = CV.Date
Where CD.continent is not null
--Order by 2,3

Select *
From PercentPopulationVaccinated





--QUERIES USED FOR TABLEAU PORTFOLIO PRACTICE PROJECT

Select Sum(New_cases) as Total_Cases, Sum(New_Deaths) as Total_Deaths, Sum(New_Deaths)/Sum
(New_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
--Group by Date
Order by 1, 2


Select location, Sum(new_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International', 'High Income', 'Upper Middle Income', 'Low Income', 'Lower Middle income')
Group by location
order by TotalDeathCount desc

--The "Above or Below" serves the same purpose

Select continent, Sum(new_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
Group by continent
order by 2 desc


Select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
Group by location, population
order by 4 desc


Select location, population, date, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
Group by location, population, date
order by 5 desc