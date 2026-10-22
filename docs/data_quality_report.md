# SocialPulse: Data Quality Report (Stage 1)

**Dataset:** Social Media Viral Content and Engagement Metrics (Kaggle, aliiihussain)
**Licence:** CC0 Public Domain (per Kaggle listing). **Nature:** synthetic (per listing).
**Size:** 2,000 rows, 15 columns, `post_id` SM_100000 to SM_101999.
**Audit script:** `sql/01_data_quality_audit.sql` (run against the unmodified `raw_posts` table, all columns loaded as text).
**Audit date:** 2026-10-12

## 1. Checks that passed

| Check | Result |
|---|---|
| Missing or blank values | 0 in all 15 columns |
| Duplicate `post_id` | None (2,000 rows, 2,000 distinct IDs) |
| Category consistency | Clean: 4 platforms, 4 content types, 6 topics, 5 languages, 5 regions, no spelling variants |
| Numeric format | All views, likes, comments, shares, engagement_rate and sentiment_score values are valid numbers |
| Negative values | None (minimums: views 4,380; likes 292; comments 14; shares 127) |
| Dates | All parse; range 2024-01-01 to 2024-12-31 |
| `engagement_rate` definition | Equals (likes + comments + shares) / views, rounded to 4 decimals, for all 2,000 rows (0 mismatches) |

## 2. Issues and risks

| # | Issue | Evidence | Risk | Proposed treatment |
|---|---|---|---|---|
| 1 | Interactions exceed views | 24 rows have likes + comments + shares > views: shares > views in 14, comments > views in 10, likes > views in 0. Max engagement_rate is 12.5732; 24 rows have rate > 1. | Implausible on a real platform. Inflates any simple average of post-level engagement rates. | Keep rows in raw. Flag them in the clean layer. Report key KPIs with and without flagged rows. |
| 2 | `is_viral` is a views threshold | Viral (1,398 posts): min views 2,002,895. Non-viral (602 posts): max views 2,000,000. The two ranges do not overlap. | Viral vs non-viral comparisons on views are circular, because views define the label. | Treat `is_viral` as a "views above 2M" segment. Compare engagement rate, not views, and state the rule in the metric dictionary. The rule is inferred from data, not documented by the source. |
| 3 | 69.9% of posts are labelled viral | 1,398 of 2,000 | "Viral" is the majority class here, not a rare event. | Describe it in the dashboard as "viral (>2M views)" and avoid claiming viral posts are exceptional. |
| 4 | `post_datetime` has no time of day | All rows end in 00:00:00 | No hour-of-day or day-part analysis is possible. | Cast to DATE. Limit time analysis to day, week and month. |
| 5 | `hashtags` is multi-value text | Several tags in one space-separated field | Cannot group by hashtag without splitting. | Exclude from the core model. Add a bridge table only if we decide to analyse hashtags. |
| 6 | Synthetic data | Near-even category counts (e.g. languages 379 to 420 posts each); metric maxima near round numbers (likes 499,983; comments 49,989; shares 99,977) | Patterns may reflect the generator, not real behaviour. | Label the project as synthetic in the README and dashboard. Phrase findings as "in this dataset". |
| 7 | `sentiment_score` scale undocumented | Observed range -1.0 to 0.999 | Positive/negative cut-offs would be invented. | Treat as a continuous -1 to 1 index. Define any bands explicitly in the metric dictionary. |

## 3. Open hypotheses still to test

- Engagement rate may fall mechanically as views rise, because likes, comments and shares appear capped while views reach 14.4M.
- Implausible content_type and platform combinations (e.g. text posts on TikTok or YouTube Shorts) appeared in the preview and have not been quantified.
- Sentiment appears unrelated to engagement in the preview; not yet tested.
