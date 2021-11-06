SELECT
  COUNT(DISTINCT utm_campaign),
  COUNT(DISTINCT utm_source)
FROM page_visits;
--counting the number of campaigns and sources

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;
--showing how campaigns and sources are related

SELECT
  COUNT(DISTINCT page_name)
FROM page_visits;
--counting how many pages are on the web site

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id
)
SELECT pv.utm_campaign,
    COUNT(ft.first_touch_at) AS '# of first touch'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;
--counting the number of First Touches for each campaign

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) last_touch_at
    FROM page_visits
    GROUP BY user_id
)
SELECT pv.utm_campaign,
    COUNT(lt.last_touch_at) AS '# of last touch'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;
--counting the number of Last Touches for each campaign

SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';
--counting how many visitors make a purchase

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id
)
SELECT pv.utm_campaign,
    COUNT(lt.last_touch_at) AS '# of last touch'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;
--counting the number of Last Touches for a purchase
