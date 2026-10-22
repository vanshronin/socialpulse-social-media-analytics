USE socialpulse;

CREATE TABLE posts_clean AS
SELECT
  post_id, platform, content_type, topic, language, region,
  DATE(post_datetime)                     AS post_date,
  hashtags,
  CAST(views AS UNSIGNED)                 AS views,
  CAST(likes AS UNSIGNED)                 AS likes,
  CAST(comments AS UNSIGNED)              AS comments,
  CAST(shares AS UNSIGNED)                AS shares,
  CAST(likes AS UNSIGNED) + CAST(comments AS UNSIGNED) + CAST(shares AS UNSIGNED) AS reactions,
  CAST(engagement_rate AS DECIMAL(10,4))  AS engagement_rate,
  CAST(sentiment_score AS DECIMAL(5,3))   AS sentiment_score,
  CAST(is_viral AS UNSIGNED)              AS is_viral,
  CASE WHEN CAST(likes AS UNSIGNED) + CAST(comments AS UNSIGNED) + CAST(shares AS UNSIGNED)
            > CAST(views AS UNSIGNED) THEN 1 ELSE 0 END AS is_flagged
FROM raw_posts;