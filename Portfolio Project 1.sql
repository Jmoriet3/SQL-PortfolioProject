--SELECT TOP (1000) [iso_code]
--      ,[continent]
--      ,[location]
--      ,[date]
--      ,[population]
--      ,[total_cases]
--      ,[new_cases]
--      ,[new_cases_smoothed]
--      ,[total_deaths]
--      ,[new_deaths]
--      ,[new_deaths_smoothed]
--      ,[total_cases_per_million]
--      ,[new_cases_per_million]
--      ,[new_cases_smoothed_per_million]
--      ,[total_deaths_per_million]
--      ,[new_deaths_per_million]
--      ,[new_deaths_smoothed_per_million]
--      ,[reproduction_rate]
--      ,[icu_patients]
--      ,[icu_patients_per_million]
--      ,[hosp_patients]
--      ,[hosp_patients_per_million]
--      ,[weekly_icu_admissions]
--      ,[weekly_icu_admissions_per_million]
--      ,[weekly_hosp_admissions]
--      ,[weekly_hosp_admissions_per_million]
--      ,[new_tests]
--  FROM [PortfolioProject ].[dbo].[CovidDeaths]

--select *
--from PortfolioProject.dbo.covidDeaths
--where continent is not null
--order by 3,4

----select *
----from PortfolioProject.dbo.covidvaccinations
--where continent is not null
----order by 3,4

            --DEATH PERCENTAGE
----select location, total_cases,total_deaths,date, (total_deaths/total_cases)*100 as DeathPercentage
----from PortfolioProject..covidDeaths
--where continent is not null
----order by 1,2

	--LIKELIHOOD OF DYING IF YOU CONTRACT COVID IN YOUR COUNTRY
----select location, total_cases,total_deaths,date, (total_deaths/total_cases)*100 as DeathPercentage
----from PortfolioProject..covidDeaths
--where continent is not null
----where location like '%Nigeria%'
----order by 1,2
      
--select location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--from PortfolioProject..covidDeaths
--where location like '%state%' and continent is not null
--order by 1,2

	--TOTAL CASES VS TOTAL POPULATION
	--shows what population has gotten Covid
--select location,date, population,total_cases, (total_cases/population)*100 as Percent_of_population_infected
--from [PortfolioProject ].dbo.CovidDeaths
--where  population is not null and total_cases is not null and continent is not null
--and location like '%state%'
--order by 1,2

--select location,date, population,total_cases, (total_cases/population)*100 as Percent_of_population_infected
--from [PortfolioProject ].dbo.CovidDeaths
--where  population is not null and total_cases is not null and continent is not null
--and location like '%nigeria%'
--order by 1,2

	  --Location and population with highest infection rate
--select location, population, max(total_cases) as highestinfectioncount, max((total_cases/population))*100 as percent_of_population_infected
--from [PortfolioProject ].dbo.CovidDeaths
--where population is not null and total_cases is not null and continent is not null
--group by location, population
--order by percent_of_population_infected desc


	--LOCATION WITH HIGHEST DEATH COUNT
--select location, max(total_deaths) as totalDeathCount 
--from [PortfolioProject ].dbo.CovidDeaths
--where  total_deaths is not null and continent is not null
--group by location
--order by totalDeathCount desc

	   --converting total_deaths from nvarchar to integer
--select location, MAX (CAST(total_deaths as int)) as totalDeathCount 
--from [PortfolioProject ].dbo.CovidDeaths
--where  total_deaths is not null and continent is not null
--group by location
--order by totalDeathCount desc

	   --BREAKING IT DOWN BY CONTINENT
	   --SHOWING CONTINENT WITH HIGHEST DEATH RATE
--select continent, MAX (CAST(total_deaths as int)) as totalDeathCount 
--from [PortfolioProject ].dbo.CovidDeaths
--where  total_deaths is not null and continent is not null
--group by continent
--order by totalDeathCount desc

--select continent, location, MAX (CAST(total_deaths as int)) as totalDeathCount 
--from [PortfolioProject ].dbo.CovidDeaths
--where  total_deaths is not null and continent is not null
--group by continent, location
--order by totalDeathCount desc


		  --SHOWING TOTAL CASES AND TOTAL DEATHS
		  --showing death percent
--select date,sum(new_cases) as totalcases, sum (cast(new_deaths as int))as totaldeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
--from [PortfolioProject ].dbo.CovidDeaths
--where continent is not null and total_cases is not null and new_deaths is not null
--group by date
--order by 1,2 

			--SHOWING TOTAL WORLD CASES,DEATHS AND DEATH PERCENTAGE
--select sum(new_cases) as totalcases, sum (cast(new_deaths as int))as totaldeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
--from [PortfolioProject ].dbo.CovidDeaths
--where continent is not null and total_cases is not null and new_deaths is not null
--order by 1,2


--select *
--from [PortfolioProject ].dbo.CovidDeaths dea
--join [PortfolioProject ].dbo.covidVaccinations vac
--   on dea.location=vac.location
--   and dea.date=vac.date


--          SHOWING con. loc.  date. pop and number vaccinated 
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--from [PortfolioProject ].dbo.CovidDeaths dea
--join [PortfolioProject ].dbo.covidVaccinations vac
--   on dea.location=vac.location
--   and dea.date=vac.date
--   where dea.continent is not null and population is not null 
--   order by 2,3
----                 SHOWING TOTAL NUMBER OF VACCINATED PERSONS PER LOCATION
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
--, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--   from [PortfolioProject ].dbo.CovidDeaths dea
--join [PortfolioProject ].dbo.covidVaccinations vac
--   on dea.location=vac.location
--   and dea.date=vac.date
--   where dea.continent is not null and population is not null and new_vaccinations is not null 
--   order by 2,3

          ----Use CTE
		  -- SHOWING PERCENTAGE OF PEOPLE VACCINATED USING A CTE
----with Popvsvac (continent, location,date, population, new_vaccinations, rollingpeoplevaccinated)
----as 
----(  
----select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
----, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
----   from [PortfolioProject ].dbo.CovidDeaths dea
----join [PortfolioProject ].dbo.covidVaccinations vac
----   on dea.location=vac.location
----   and dea.date=vac.date
----   where dea.continent is not null 
----   and population is not null and new_vaccinations is not null 
----)
----select *, (rollingpeoplevaccinated/population)*100
----from Popvsvac


        --Temp Table
		---SHOWING PERCENTAGE OF THE POPULATION VACCINATED USING A TEMP TABLE
--DROP table if exists #Percentpopulationvaccinated
--create Table #Percentpopulationvaccinated
--(
--continent nvarchar(255),
--location nvarchar(255),
--population numeric,
--date datetime,
--new_vaccinations numeric,
--rollingpeoplevaccinated numeric
--)
--insert into #Percentpopulationvaccinated(continent, location,date, population, new_vaccinations, rollingpeoplevaccinated)
--(  
--select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
--, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--   from [PortfolioProject ].dbo.CovidDeaths dea
--join [PortfolioProject ].dbo.covidVaccinations vac
--   on dea.location=vac.location
--   and dea.date=vac.date
--   where dea.continent is not null 
--   and population is not null and new_vaccinations is not null 
--)
--select *, (rollingpeoplevaccinated/population)*100
--from #Percentpopulationvaccinated


              --CREATE VIEW FOR LATER VISUALIZATION
----create view PercentPopulationVacinated 
----AS 
----select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
----, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
----   from [PortfolioProject ].dbo.CovidDeaths dea
----join [PortfolioProject ].dbo.covidVaccinations vac
----   on dea.location=vac.location
----   and dea.date=vac.date
----   where dea.continent is not null and population is not null and new_vaccinations is not null 


----select *
----from PercentPopulationVacinated 
