-- DATA CLEANING 

SELECT *
FROM layoffs;

-- REMOVING DUPLICATE VALUES
    
CREATE TABLE `layoffs_cleaning` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_cleaning;

INSERT INTO `layoffs_cleaning`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM layoffS
		;

DELETE FROM layoffS_cleaning
WHERE row_num >= 2;

-- STANDARDIZATION DATA
SELECT *
FROM layoffs_cleaning;

SELECT DISTINCT company
FROM layoffs_cleaning;

UPDATE layoffs_cleaning
SET company = TRIM(company);

SELECT DISTINCT location
FROM layoffs_cleaning;

SELECT DISTINCT industry
FROM layoffs_cleaning;

UPDATE layoffs_cleaning
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

UPDATE layoffs_cleaning
SET `date` = STR_TO_DATE(`date`, '%m/%Y/%d');

-- REMOVING NULL VALUES

UPDATE layoffs_cleaning
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_cleaning l1
JOIN layoffs_cleaning l2
ON  l1.company = l2.company
SET l1.industry = l2.industry
WHERE l1.industry IS NULL 
AND l2.industry IS NOT NULL
;

-- REMOVE UNWANTED COLUMN

DELETE FROM layoffs_cleaning
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_cleaning
DROP column row_num;


