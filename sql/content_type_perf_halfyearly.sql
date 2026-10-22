USE socialpulse;

SELECT
  content_type,
  CASE WHEN MONTH(post_date) <= 6 THEN 'Jan-Jun' ELSE 'Jul-Dec' END AS half_year,
  COUNT(*)           AS posts,
  ROUND(AVG(views))  AS avg_views
FROM posts_clean
GROUP BY content_type, half_year
ORDER BY half_year, avg_views DESC;