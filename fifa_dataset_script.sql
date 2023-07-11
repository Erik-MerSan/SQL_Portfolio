-- showing the stucture of the data

SELECT *
FROM public.fifa23_official_data fod ;

-- showing the top 10 players in the datset

SELECT "Name", overall, "Position", nationality, club
FROM public.fifa23_official_data 
ORDER BY overall DESC  
LIMIT 10;

-- showing the bottom 10 players in the zataset
 
SELECT "Name", overall, nationality, club
FROM public.fifa23_official_data 
ORDER BY overall 
LIMIT 10;

-- showing the top 10 countries based on average rating 

SELECT nationality AS country, avg(overall) AS avg_overall
FROM public.fifa23_official_data
GROUP BY nationality 
ORDER BY avg(overall) DESC 
LIMIT 10;

-- showing the top 10 clubs based on average rating

SELECT club, avg(overall) AS avg_overall
FROM public.fifa23_official_data
GROUP BY club 
ORDER BY avg(overall) DESC 
LIMIT 10;

-- showing the 10 countries with the most players from there

SELECT nationality AS country, count("Name") AS number_of_players
FROM public.fifa23_official_data fod 
GROUP BY nationality 
ORDER BY count("Name") DESC 
LIMIT 10;

-- showing the number of players based on preferred foot

SELECT "Preferred Foot", count("Name") AS number_of_players
FROM public.fifa23_official_data fod 
GROUP BY "Preferred Foot"; 
