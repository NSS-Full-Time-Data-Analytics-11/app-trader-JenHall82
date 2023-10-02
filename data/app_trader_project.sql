WITH rating_table AS(SELECT name, (asa.rating + psa.rating/2) AS avg_rating
					FROM app_store_apps AS asa 
					INNER JOIN play_store_apps AS psa USING (name))
SELECT name, ROUND(avg_rating/25,2)*25
FROM rating_table;

SELECT name, ROUND(((asa.rating + psa.rating/2)/25)*25,2) AS avg_rating
					FROM app_store_apps AS asa 
					INNER JOIN play_store_apps AS psa USING (name);
					
WITH rating_table AS (SELECT name AS app_name, ROUND((asa.rating + psa.rating)/2,2) AS avg_rating, asa.content_rating AS age_rating, primary_genre AS genre, ROUND(TRIM(psa.price::varchar, '$')::decimal) AS store_price
						 FROM app_store_apps AS asa INNER JOIN play_store_apps AS psa USING (name))

SELECT app_name, ROUND(FLOOR(avg_rating *4)/4,2) AS avg_quarter_point_rating, age_rating, store_price::money, genre,
						  CASE WHEN store_price::decimal = 0 THEN '$25,000'
					 	  	   WHEN store_price::decimal  > 0 THEN (store_price::decimal * 10000)::money END AS buying_price
FROM rating_table
GROUP BY app_name, avg_rating, buying_price, age_rating, store_price, genre
ORDER BY buying_price DESC, avg_quarter_point_rating DESC;





					


