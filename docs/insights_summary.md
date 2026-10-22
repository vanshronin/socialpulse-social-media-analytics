# SocialPulse: Findings and Recommendations

**Dataset:** 2,000 synthetic posts (Kaggle, CC0), four platforms, all of 2024.
**Important:** the data is synthetic. These are patterns in this dataset, not evidence about real social media.

## Executive summary

The data does not support choosing a "best" platform, content type, topic or month. The strongest results are about the data itself: engagement rate is driven mainly by how many views a post has, "viral" is only a views cutoff, and 24 posts have impossible numbers. The most useful outcome is a set of metric rules and a list of experiments, described below.

## Findings

### 1. The four platforms perform almost identically
- **Evidence:** engagement rate ranges from 7.32% (TikTok) to 7.54% (Instagram). Average views range from 4.23M to 4.36M. Viral share ranges from 68.7% to 70.9%.
- **Interpretation:** the gap between best and worst is about 0.2 percentage points, too small to act on.
- **Limitation:** synthetic data with near-even category counts, so real platforms would differ.
- **Recommendation:** do not shift budget between platforms based on this data.
- **Next step:** run a controlled test, posting the same content on two platforms at the same time and comparing results.

### 2. Engagement rate falls as views rise, because comments and shares do not
- **Evidence:** average comments stay around 24K to 26K and average shares around 48K to 51K in every view band, from under 100K to over 10M views. The pooled engagement rate falls from 164.9% (under 100K views) to 4.5% (over 10M).
- **Interpretation:** a post with few views looks "highly engaging" mainly because the number it is divided by is small.
- **Limitation:** comments and shares that ignore reach are unlike real platforms, which suggests the data was generated.
- **Recommendation:** compare content only among posts with similar views, and show average views next to every rate.
- **Next step:** track reactions per post as well as the rate.

### 3. "Viral" is only a views cutoff
- **Evidence:** all 1,398 viral posts have more than 2,000,000 views, and all 602 non-viral posts have 2,000,000 or fewer, with no overlap. 69.9% of posts count as viral. Non-viral posts show a higher engagement rate (16.9% vs 6.75%), but this comes from their smaller view counts.
- **Interpretation:** the label tells us a post is large, not why it spread.
- **Limitation:** the rule is inferred from the data, not documented by the source.
- **Recommendation:** if the team cares about virality, define it with something more meaningful than views alone, such as shares per view.

### 4. Video has a slight lead on average views, which is not confirmed
- **Evidence:** video averages 4.53M views against 4.16M to 4.26M for the other types (about 6% to 9% ahead), and it led in both halves of the year. The order of the other three types changed between halves.
- **Interpretation:** weak evidence at best. With four groups, one leading twice happens by chance fairly often.
- **Limitation:** no significance test was run.
- **Recommendation:** treat video as a hypothesis to test, not a result.
- **Next step:** run a test where matched topics are posted as video and non-video, with a sample size fixed in advance.

### 5. Twenty-four posts have impossible numbers
- **Evidence:** 24 posts have more likes, comments and shares combined than views, with engagement rates up to 1,257%. All have between 4,380 and 161,252 views. They lift the non-viral average post rate from 0.2079 to 0.3397.
- **Interpretation:** these are probably errors, and a simple average of post-level rates would be badly distorted by them. The pooled rate is hardly affected.
- **Recommendation:** use the pooled rate as the headline metric, and add a check that flags any post where reactions exceed views.

## What the data does not show
- No meaningful difference between months. Average views move up and down with no trend.
- Only a modest spread across topics (about 12% between Politics and Sports on views), which is not confirmed.
- No link between sentiment and engagement or viral status: average sentiment is about zero in both groups.

## Limitations
- Synthetic data, so findings describe this dataset only.
- Dates have no time of day, so there is no analysis by hour.
- No significance tests were run, so small differences are described as unconfirmed.
- Hashtags were not analysed.

## Recommended next steps
1. Adopt the pooled engagement rate with average views shown beside it, as defined in the metric dictionary.
2. Add an automatic check for posts where reactions exceed views.
3. Run one controlled experiment on content type (finding 4) before changing the content mix.
