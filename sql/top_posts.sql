USE socialpulse;

SELECT post_id, platform, content_type, topic,
       ROUND(views / 1000000, 2) AS views_millions,
       reactions,
       engagement_rate
FROM posts_clean
ORDER BY reactions DESC
LIMIT 10;