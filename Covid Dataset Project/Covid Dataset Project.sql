Create database CovidProject
--Drop Database CovidProject

Select * 
From CovidProject..CovidDataset



----GLOBAL RECORDS TAB
Select sum(new_cases) 'Total Cases',
		sum(new_deaths) 'Total Deaths',
		sum(new_tests) 'Total Tests',
		sum(new_vaccinations) 'Total Vaccinations',
		avg(new_cases) 'Avg. Total Cases',
		stdev(new_cases) 'St. Dev. New Cases'
From CovidProject..CovidDataset
Where Continent is not null


----FILTER TAB BY YEAR & CONTINENT
Select Year(Date) 'Select Year:'
From CovidProject..CovidDataset
Where continent is not null
Group by Year(date)

Select Continent 'Select Continent'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent


----TOTAL CASES & DEATHS BY YEAR
Select Continent, Date,
		sum(new_cases) 'Total Cases'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent, date

Select Continent, Date,
		sum(new_deaths) 'Total Deaths'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent, date



----TOTAL CASES, DEATHS & VACCINATIONS BY CONTINENT
Select Distinct Continent,sum(new_cases) 'Total Cases'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent
Order by 1, 2

Select Distinct Continent,sum(new_deaths) 'Total Deaths'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent
Order by 1, 2

Select Distinct Continent,sum(new_vaccinations) 'Total Vaccinations'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent
Order by 1, 2


----RATE OF POSITIVE RESULT BY CONTINENT
Select Distinct Continent, avg(positive_rate) 'Positive Rate Result'
From CovidProject..CovidDataset
Where Continent is not null
Group by Continent
Order by 1, 2

----DISCREPANCIES WITH THE RECORDS
Select Location,
		Sum(new_cases) 'Sum New Cases', Max(total_cases) 'Max Total Cases',
	Case
		When Sum(new_cases) = Max(total_cases) Then 'True'
		Else 'False'
	End 'Sum = Max (Cases)',
		Sum(new_deaths) 'Sum New Deaths', Max(total_deaths) 'Max Total Deaths',
	
	Case
		When Sum(new_deaths) = Max(total_deaths) Then 'True'
		Else 'False'
	End 'Sum = Max (Deaths)'
From CovidProject..CovidDataset
Where continent is not null
Group by location
Order by 2 desc

