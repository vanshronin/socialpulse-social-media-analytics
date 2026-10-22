USE socialpulse;

SELECT
  CASE WHEN is_viral = 1 THEN 'Viral (over 2M views)' ELSE 'Not viral' END AS group_name,
  COUNT(*)                                  AS posts,
  ROUND(AVG(views) / 1000000, 2)            AS avg_views_millions,
  ROUND(SUM(reactions) / SUM(views), 4)     AS engagement_rate,
  ROUND(AVG(likes))                         AS avg_likes,
  ROUND(AVG(comments))                      AS avg_comments,
  ROUND(AVG(shares))                        AS avg_shares,
  ROUND(AVG(sentiment_score), 3)            AS avg_sentiment
FROM posts_clean
GROUP BY is_viral
ORDER BY is_viral DESC;