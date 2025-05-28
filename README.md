# Netflix Data Analysis with SQL

![Netflix Logo](https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg)

## 📌 Project Overview
This SQL analysis explores Netflix's content catalog to uncover insights about content distribution, production trends, and creative collaborations. The project uses PostgreSQL to analyze a dataset of Netflix movies and TV shows.

**Dataset Source**: [Netflix Movies and TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)  
**Last Updated**: June 2023  
**Tools Used**: PostgreSQL, pgAdmin  

##  Database Schema
```sql
CREATE TABLE netflix(
  show_id     VARCHAR(10) PRIMARY KEY,
  kind        VARCHAR(10) NOT NULL CHECK (kind IN ('Movie', 'TV Show')),
  title       VARCHAR(150) NOT NULL,
  director    VARCHAR(220),
  performers  TEXT,
  country     VARCHAR(150),
  date_added  DATE,  
  release_year INT CHECK
```
## Content Distribution
```sql
-- Content type breakdown
SELECT 
  kind,
  COUNT(*) AS count,
  ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(), 1) AS percentage
FROM netflix
GROUP BY kind;
```
## Production Trends
```sql
-- Top 10 production countries
WITH country_exploded AS (
  SELECT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country
  FROM netflix
  WHERE country IS NOT NULL
)
SELECT 
  country,
  COUNT(*) AS production_count,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM country_exploded
GROUP BY country
ORDER BY production_count DESC
LIMIT 10;
```
## Content Duration Analysis
```sql
-- Longest movies
SELECT 
  title,
  CAST(SUBSTRING(duration FROM '(\d+) min') AS INT) AS minutes
FROM netflix
WHERE kind = 'Movie'
ORDER BY minutes DESC
LIMIT 5;

-- TV shows with most seasons
SELECT 
  title,
  CAST(SUBSTRING(duration FROM '(\d+) Season') AS INT) AS seasons
FROM netflix
WHERE kind = 'TV Show'
ORDER BY seasons DESC
LIMIT 5;
```
## Top Actors & Collaborations
```sql
-- Top 10 US Movie Actors
WITH us_movies AS (
  SELECT UNNEST(STRING_TO_ARRAY(performers,',')) AS actor
  FROM netflix 
  WHERE country LIKE '%United States%' AND kind='Movie'
)
SELECT TRIM(actor) AS actor_name, COUNT(*) AS appearances
FROM us_movies GROUP BY actor_name ORDER BY appearances DESC LIMIT 10;

-- Frequent Director-Actor Pairs
SELECT director, TRIM(actor) AS actor, COUNT(*) AS collaborations
FROM (
  SELECT director, UNNEST(STRING_TO_ARRAY(performers,',')) AS actor
  FROM netflix WHERE director IS NOT NULL
) t GROUP BY director, actor HAVING COUNT(*) > 1 ORDER BY collaborations DESC;
Data Validation: CHECK constraints on schema
```
##  How to Run

1. Load your dataset into a PostgreSQL-compatible database.
2. Create the `netflix` table using the schema provided.
3. Run the queries from `solutions.sql`.
4. Analyze or visualize the results using your preferred BI tool or SQL client.

