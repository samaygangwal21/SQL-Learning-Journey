-- EDA : Exploratory Data Analysis

SELECT * 
FROM layoffs_cleaning;

-- MAXIMUM AND MINIMUM Layoffs
SELECT MAX(total_laid_off), MIN(total_laid_off)
FROM layoffs_cleaning;


-- Top 10 Companies with most laid offs
SELECT company, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
LIMIT 10 ;

-- Laid offs of Top 10 companies with highest funds raised
SELECT company, SUM(total_laid_off) total_laid_off, MAX(funds_raised_millions) funds_raised_millions
FROM layoffs_cleaning
GROUP BY company
ORDER BY MAX(funds_raised_millions) DESC
LIMIT 10 ;

-- Top 10 Locations with most laid offs
SELECT location, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY location
ORDER BY SUM(total_laid_off) DESC
LIMIT 10 ;

-- Top 10 Countries with most laid offs in descending order
SELECT country, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY country
ORDER BY SUM(total_laid_off) DESC ;

-- Industry with most laid offs in descending order
SELECT industry, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;

-- Stage-wise laid offs
SELECT stage, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY stage
ORDER BY 2 DESC ;

-- Year-wise laid offs
SELECT YEAR(`date`) YEAR, SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
GROUP BY YEAR(`date`)
ORDER BY 1 DESC ;

-- Month-wise laid offs
SELECT SUBSTRING(`date`, 1, 7) AS Month , SUM(total_laid_off) total_laid_off
FROM layoffs_cleaning
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY SUBSTRING(`date`, 1, 7) 
ORDER BY 1  ;

-- Rolling Sum Monthwise
WITH Rolling_Sum AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `Month` , SUM(total_laid_off) total_laid_offs
FROM layoffs_cleaning
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Month` 
)
SELECT `Month` , total_laid_offs AS Monthly_Total , SUM(total_laid_offs)
OVER(ORDER BY `Month`) Rolling_Total
FROM Rolling_Sum;

-- Top 3 most laid offs by a company every year
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_cleaning
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;


