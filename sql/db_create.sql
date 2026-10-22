create database if not exists SocialPulse;
use SocialPulse;

CREATE TABLE raw_posts (
    post_id          VARCHAR(50),
    platform         VARCHAR(100),
    content_type     VARCHAR(100),
    topic            VARCHAR(100),
    language         VARCHAR(50),
    region           VARCHAR(100),
    post_datetime    VARCHAR(50),
    hashtags         VARCHAR(500),
    views            VARCHAR(50),
    likes            VARCHAR(50),
    comments         VARCHAR(50),
    shares           VARCHAR(50),
    engagement_rate  VARCHAR(50),
    sentiment_score  VARCHAR(50),
    is_viral         VARCHAR(50)
);

select count(*) as TotalCount, count(distinct post_id) as TotalPostIds, min(post_id) as firstPostId, max(post_id) as lastPostId from raw_posts;