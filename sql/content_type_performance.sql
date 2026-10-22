USE socialpulse;

SELECT
  content_type,
  COUNT(*)                                   AS posts,
  ROUND(AVG(views))                          AS avg_views,
  ROUND(SUM(reactions) / SUM(views), 4)      AS engagement_rate,
  ROUND(SUM(CASE WHEN is_flagged = 0 THEN reactions END)
        / SUM(CASE WHEN is_flagged = 0 THEN views END), 4) AS rate_without_flagged,
  ROUND(100 * SUM(is_viral) / COUNT(*), 1)   AS viral_pct
FROM posts_clean
GROUP BY content_type
ORDER BY engagement_rate DESC;