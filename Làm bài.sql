--Alter table PortfolioProject..CovidDeaths
--Alter column total_deaths float
--Alter table PortfolioProject..CovidDeaths
--Alter column total_cases float
--Alter table PortfolioProject..CovidDeaths
--Alter column new_cases float
--Alter table PortfolioProject..CovidDeaths
--Alter column new_deaths float
--Alter table PortfolioProject..CovidVaccinations
--Alter column new_vaccinations float


--Select location, date, total_cases, total_deaths, population
--From PortfolioProject..CovidDeaths
--Order by 1,2

--Likelihood of dying if you contract covid in your country
--Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--Where location like '%states'
--Order by 1,2

--Countries With Infection rate compared to population
--Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
--From PortfolioProject..CovidDeaths
--Where location like '%states'
--Order by 1,2

--Countries With Highest Infection rate compared to population
--Select location, Max(total_cases) as HighestInfectionCount, population, max(total_cases/population)*100 as PercentPopulationInfected
--From PortfolioProject..CovidDeaths
--Group by location, population
--Order by PercentPopulationInfected desc

--Countries With Highest Death Count Per Population
--Select location, Max(total_deaths) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--Where continent is not null
--Group by location
--Order by TotalDeathCount desc

--Select continent, Max(total_deaths) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--Where continent is not null
--Group by continent
--Order by TotalDeathCount desc

--Select sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, sum(new_deaths)/sum(new_cases)*100 as GlobalDeathPercentage
--From PortfolioProject..CovidDeaths
--where new_cases > 0
--and new_deaths >0
--and continent is not null
----group by date
--Order by 1,2

--Looking at Total population vs Vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated, 
--(RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	On vac.location = dea.location
	and vac.date = dea.date
where dea.continent is not null
Order by 2,3




