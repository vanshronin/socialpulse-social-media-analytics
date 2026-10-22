use SocialPulse;

SELECT
  SUM(post_id IS NULL OR TRIM(post_id) = '')                   AS post_id,
  SUM(platform IS NULL OR TRIM(platform) = '')                 AS platform,
  SUM(content_type IS NULL OR TRIM(content_type) = '')         AS content_type,
  SUM(topic IS NULL OR TRIM(topic) = '')                       AS topic,
  SUM(language IS NULL OR TRIM(language) = '')                 AS language,
  SUM(region IS NULL OR TRIM(region) = '')                     AS region,
  SUM(post_datetime IS NULL OR TRIM(post_datetime) = '')       AS post_datetime,
  SUM(hashtags IS NULL OR TRIM(hashtags) = '')                 AS hashtags,
  SUM(views IS NULL OR TRIM(views) = '')                       AS views,
  SUM(likes IS NULL OR TRIM(likes) = '')                       AS likes,
  SUM(comments IS NULL OR TRIM(comments) = '')                 AS comments,
  SUM(shares IS NULL OR TRIM(shares) = '')                     AS shares,
  SUM(engagement_rate IS NULL OR TRIM(engagement_rate) = '')   AS engagement_rate,
  SUM(sentiment_score IS NULL OR TRIM(sentiment_score) = '')   AS sentiment_score,
  SUM(is_viral IS NULL OR TRIM(is_viral) = '')                 AS is_viral
FROM raw_posts;


use SocialPulse;

SELECT 'platform' AS col, platform AS value, COUNT(*) AS n FROM raw_posts GROUP BY platform
UNION ALL SELECT 'content_type', content_type, COUNT(*) FROM raw_posts GROUP BY content_type
UNION ALL SELECT 'topic', topic, COUNT(*) FROM raw_posts GROUP BY topic
UNION ALL SELECT 'language', language, COUNT(*) FROM raw_posts GROUP BY language
UNION ALL SELECT 'region', region, COUNT(*) FROM raw_posts GROUP BY region
UNION ALL SELECT 'is_viral', is_viral, COUNT(*) FROM raw_posts GROUP BY is_viral
ORDER BY col, n DESC;


use SocialPulse;

SELECT
  SUM(views NOT REGEXP '^[0-9]+$')                     AS bad_views,
  SUM(likes NOT REGEXP '^[0-9]+$')                     AS bad_likes,
  SUM(comments NOT REGEXP '^[0-9]+$')                  AS bad_comments,
  SUM(shares NOT REGEXP '^[0-9]+$')                    AS bad_shares,
  SUM(engagement_rate NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$') AS bad_rate,
  SUM(sentiment_score NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$') AS bad_sentiment,
  MIN(CAST(views AS SIGNED))    AS min_views,    MAX(CAST(views AS SIGNED))    AS max_views,
  MIN(CAST(likes AS SIGNED))    AS min_likes,    MAX(CAST(likes AS SIGNED))    AS max_likes,
  MIN(CAST(comments AS SIGNED)) AS min_comments, MAX(CAST(comments AS SIGNED)) AS max_comments,
  MIN(CAST(shares AS SIGNED))   AS min_shares,   MAX(CAST(shares AS SIGNED))   AS max_shares,
  MIN(CAST(engagement_rate AS DECIMAL(10,4))) AS min_rate, MAX(CAST(engagement_rate AS DECIMAL(10,4))) AS max_rate,
  MIN(CAST(sentiment_score AS DECIMAL(10,4))) AS min_sent, MAX(CAST(sentiment_score AS DECIMAL(10,4))) AS max_sent
FROM raw_posts;


use SocialPulse;

SELECT
  SUM(STR_TO_DATE(post_datetime,'%Y-%m-%d %H:%i:%s') IS NULL) AS unparseable_dates,
  MIN(post_datetime) AS first_date,
  MAX(post_datetime) AS last_date,
  SUM(post_datetime NOT LIKE '% 00:00:00') AS rows_with_a_time_of_day
FROM raw_posts;


use SocialPulse;

SELECT
  SUM(CAST(shares AS SIGNED)   > CAST(views AS SIGNED)) AS shares_gt_views,
  SUM(CAST(likes AS SIGNED)    > CAST(views AS SIGNED)) AS likes_gt_views,
  SUM(CAST(comments AS SIGNED) > CAST(views AS SIGNED)) AS comments_gt_views,
  SUM(CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED) > CAST(views AS SIGNED)) AS interactions_gt_views,
  SUM(CAST(engagement_rate AS DECIMAL(10,4)) > 1)       AS rate_gt_1,
  SUM(ABS(ROUND((CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED))
        / CAST(views AS SIGNED), 4) - CAST(engagement_rate AS DECIMAL(10,4))) > 0.0001) AS rate_mismatch
FROM raw_posts;


use SocialPulse;

SELECT is_viral,
       COUNT(*) AS posts,
       MIN(CAST(views AS SIGNED)) AS min_views,
       MAX(CAST(views AS SIGNED)) AS max_views
FROM raw_posts
GROUP BY is_viral;


USE socialpulse;

-- Q7. Three ways to compute engagement rate, by viral group
SELECT
  is_viral,
  COUNT(*) AS posts,
  ROUND(AVG(CAST(engagement_rate AS DECIMAL(10,4))), 4) AS avg_post_rate_all,
  ROUND(AVG(CASE WHEN CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED) <= CAST(views AS SIGNED)
                 THEN CAST(engagement_rate AS DECIMAL(10,4)) END), 4) AS avg_post_rate_excl_flagged,
  ROUND(SUM(CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED))
        / SUM(CAST(views AS SIGNED)), 4) AS pooled_rate_all
FROM raw_posts
GROUP BY is_viral;


use SocialPulse;

-- Q8. Profile of the 24 flagged posts
SELECT COUNT(*) AS flagged_posts,
       MIN(CAST(views AS SIGNED)) AS min_views,
       MAX(CAST(views AS SIGNED)) AS max_views,
       SUM(is_viral = '1') AS flagged_that_are_viral
FROM raw_posts
WHERE CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED) > CAST(views AS SIGNED);


USE socialpulse;

-- Q9. Do interactions grow with views? Average counts and pooled rate by view band
SELECT
  CASE
    WHEN CAST(views AS SIGNED) <= 100000   THEN '1: up to 100K'
    WHEN CAST(views AS SIGNED) <= 500000   THEN '2: 100K-500K'
    WHEN CAST(views AS SIGNED) <= 1000000  THEN '3: 500K-1M'
    WHEN CAST(views AS SIGNED) <= 2000000  THEN '4: 1M-2M'
    WHEN CAST(views AS SIGNED) <= 5000000  THEN '5: 2M-5M'
    WHEN CAST(views AS SIGNED) <= 10000000 THEN '6: 5M-10M'
    ELSE '7: above 10M'
  END AS view_band,
  COUNT(*) AS posts,
  ROUND(AVG(CAST(likes AS SIGNED)))    AS avg_likes,
  ROUND(AVG(CAST(comments AS SIGNED))) AS avg_comments,
  ROUND(AVG(CAST(shares AS SIGNED)))   AS avg_shares,
  ROUND(SUM(CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED))
        / SUM(CAST(views AS SIGNED)), 4) AS pooled_rate
FROM raw_posts
GROUP BY view_band
ORDER BY view_band;

USE socialpulse;

-- Q9. Do interactions grow with views? Average counts and pooled rate by view band
SELECT
  CASE
    WHEN CAST(views AS SIGNED) <= 100000   THEN '1: up to 100K'
    WHEN CAST(views AS SIGNED) <= 500000   THEN '2: 100K-500K'
    WHEN CAST(views AS SIGNED) <= 1000000  THEN '3: 500K-1M'
    WHEN CAST(views AS SIGNED) <= 2000000  THEN '4: 1M-2M'
    WHEN CAST(views AS SIGNED) <= 5000000  THEN '5: 2M-5M'
    WHEN CAST(views AS SIGNED) <= 10000000 THEN '6: 5M-10M'
    ELSE '7: above 10M'
  END AS view_band,
  COUNT(*) AS posts,
  ROUND(AVG(CAST(likes AS SIGNED)))    AS avg_likes,
  ROUND(AVG(CAST(comments AS SIGNED))) AS avg_comments,
  ROUND(AVG(CAST(shares AS SIGNED)))   AS avg_shares,
  ROUND(SUM(CAST(likes AS SIGNED)+CAST(comments AS SIGNED)+CAST(shares AS SIGNED))
        / SUM(CAST(views AS SIGNED)), 4) AS pooled_rate
FROM raw_posts
GROUP BY view_band
ORDER BY view_band;