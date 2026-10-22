# SocialPulse: Metric Dictionary

A plain-English list of every number used in the dashboard: what it means, how it is calculated, and what to be careful about.

**Reactions** means likes + comments + shares on a post.

| Metric | What it means | How it is calculated | Careful about |
|---|---|---|---|
| Total posts | How many posts there are | Count of rows | The 24 flagged posts are counted here. |
| Total views | How many times posts were seen | Sum of views | None. |
| Total reactions | All likes, comments and shares together | Sum of likes + comments + shares | None. |
| **Engagement rate (headline)** | Out of every 100 views, how many turned into a reaction | Total reactions ÷ total views (the "pooled" rate) | Falls as views grow, because comments and shares do not grow with views in this data. Always show average views next to it. |
| Average post engagement rate (secondary) | The typical post's rate, each post counted equally | Average of each post's (reactions ÷ views) | A few tiny posts with huge rates can distort it. Use it only as a second view, never as the headline. |
| Viral posts | Posts with more than 2,000,000 views | Views above 2,000,000 | This is only a view cutoff. It is not a measure of quality or spread. |
| Viral share | What portion of posts are viral | Viral posts ÷ total posts | About 70% of posts are viral here, so it is the majority, not the exception. |
| Average views per post | How big a typical post is | Total views ÷ total posts | Large posts pull this up. |
| Average sentiment | General tone of the posts | Average of sentiment_score | The score runs from -1 to +1, but the source does not explain what it means. Do not call posts "positive" or "negative" without a defined cutoff. |
| Posts per month | How much was posted over time | Count of posts by month of post date | Dates have no time of day, so we can only look at day, week and month. |

## Rules for the 24 flagged posts
24 posts have more reactions than views, which cannot happen on a real platform. They stay in the data. Wherever a rate is shown, we also show it without these posts, so the effect is visible.

## Rules for comparing groups
When comparing platforms, content types or topics on engagement rate, always show average views next to the rate. A group can look better only because its posts are smaller.
