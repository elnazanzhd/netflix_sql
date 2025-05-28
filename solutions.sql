CREATE TABLE netflix(

	show_id		VARCHAR(10),
	kind 		VARCHAR(10),
	title 		VARCHAR(150),
	director 	VARCHAR(220),
	performers  VARCHAR(1000),
	country		VARCHAR(150),
	date_added  VARCHAR(50),	
	release_year INT ,
	rating		VARCHAR(12),
	duration	VARCHAR(20),
	listed_in	VARCHAR(100),
	description VARCHAR(255)

);
 --DROP TABLE netflix

SELECT * FROM netflix;

SELECT COUNT(DISTINCT release_year) FROM netflix;
SELECT DISTINCT kind FROM netflix;
SELECT DISTINCT rating FROM netflix;

SELECT COUNT(*) FROM netflix;
SELECT kind,COUNT(*) FROM netflix GROUP BY  kind;

SELECT 
  release_year,
  COUNT(*) 
FROM netflix
GROUP BY release_year
ORDER BY Count(*) DESC;

--business problems :

--top 10 countries with the most content on Netflix

SELECT 
	country,
	COUNT(*) 
FROM netflix
WHERE country IS NOT NULL
	GROUP BY country
	ORDER by COUNT(*) DESC
LIMIT 10




--find the longest movie and TV show
(
SELECT title,
       kind
FROM(
	SELECT 
    	title,
		kind,
    	CAST(SUBSTRING(duration FROM '([0-9]+) min') AS INTEGER) AS minutes
	FROM netflix 
	)as t1
WHERE minutes IS NOT NULL
ORDER BY minutes DESC
LIMIT 1
)
UNION ALL
(
SELECT 
    title,
    kind
FROM (
    SELECT 
        title,
		kind,
        CAST(
            CASE
                WHEN duration ~ '[0-9]+ Season' THEN SUBSTRING(duration FROM '([0-9]+) Season')
                WHEN duration ~ '[0-9]+ Seasons' THEN SUBSTRING(duration FROM '([0-9]+) Seasons')
            END
        AS INTEGER) AS seasons
    FROM netflix
    
) AS tv_shows
WHERE seasons IS NOT NULL
ORDER BY seasons DESC
LIMIT 1
)



--list all the TV shows with more than 6 seasons
SELECT title,
		seasons
FROM
	(SELECT title,
			duration,
			kind,
			CAST(
				CASE
					WHEN duration LIKE '% Seasons'THEN SUBSTRING(duration FROM'([0-9]+) Seasons')
					WHEN duration LIKE '% Season'THEN SUBSTRING(duration FROM'([0-9]+) Season')
				END
			AS INTEGER) AS seasons
	FROM netflix
	WHERE kind='TV Show'
	)AS tvshows
	WHERE seasons>6
	ORDER BY seasons DESC
	
			

--count the number of content items in each genre

SELECT COUNT(*),
		listed_in
FROM netflix
GROUP BY listed_in
ORDER BY COUNT(*) DESC
		

--find the top 10 actors who have appeared in the highest number of movies produced in USA
WITH us_movies AS (
    SELECT 
        show_id,
        title,
        performers  
    FROM netflix
    WHERE 
        kind = 'Movie'
        AND country LIKE '%United States%'
),

actor_appearances AS (
    SELECT 
        TRIM(UNNEST(STRING_TO_ARRAY(performers, ','))) AS actor_name, --creates a colomn of actors name with diffrent frequencies(appearances)
        COUNT(*) AS movie_count
    FROM us_movies
    WHERE performers IS NOT NULL
    GROUP BY actor_name
)

SELECT 
    actor_name,
    movie_count
FROM actor_appearances
ORDER BY movie_count DESC
LIMIT 10;


--find the most common rating for movies and TV shows


SELECT 
	kind,
	rating 
FROM 
	(SELECT 
		kind,
		COUNT(*),
		rating,
		RANK() OVER (PARTITION BY kind -- Separates the ranking by content type (Movies and TV Shows ranked separately)
		ORDER BY COUNT(*) DESC) AS ranking 
	FROM netflix
	GROUP BY kind, rating )
as table1
WHERE ranking=1;

--collaborations between directors and actors
WITH collaborations AS (
  SELECT 
    director,
    TRIM(actor) AS actor,
    COUNT(*) AS movies_together
  FROM (
    SELECT 
      director,
      UNNEST(STRING_TO_ARRAY(performers, ',')) AS actor
    FROM netflix
    WHERE director IS NOT NULL
  ) t
  GROUP BY director, actor
)
SELECT * FROM collaborations
WHERE movies_together > 1
ORDER BY movies_together DESC;



