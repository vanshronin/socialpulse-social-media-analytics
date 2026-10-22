USE socialpulse;

SELECT
  DATE_FORMAT(post_date, '%Y-%m')             AS post_month,
  COUNT(*)                                    AS posts,
  ROUND(AVG(views) / 1000000, 2)              AS avg_views_millions,
  ROUND(SUM(reactions) / SUM(views), 4)       AS engagement_rate
FROM posts_clean
GROUP BY post_month
ORDER BY post_month;