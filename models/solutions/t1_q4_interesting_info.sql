-- Query 1: Weekly Job Postings
-- This query counts how many job postings were created each week. 
-- In the third week of January 2019, we see the highest number of postings across the first 4 weeks.

select week_id, count(posting_id)
from {{ ref("stg_job_postings") }}
group by week_id
order by week_id

-- ---------------

-- -- Query 2: Job Types Distribution
-- -- This query breaks down job postings by type (full-time, part-time, etc.) to see which categories dominate. 
-- -- Full-time jobs had the highest number of postings, followed by part-time. Only 66 postings were for voluntary jobs.

select job_type, count(posting_id)
from {{ ref("stg_job_postings") }}
group by job_type
order by count(posting_id) desc

-- ---------------

-- -- Query 3: Paid vs Unpaid Clicks
-- -- This query compares the volume of paid vs unpaid clicks in the clicks dataset (covers 9 weeks). 
-- -- Unpaid clicks were higher (561k) compared to paid clicks (438k).

select
    case
        when click_type = true then 'Paid'
        when click_type = false then 'Unpaid'
    end as click_type_label,
    count(*) as clicks_count
from {{ ref("stg_clicks_data") }}
group by click_type

-- ---------------

-- -- Query 4: Most Popular Jobs (Clicks by Posting)
-- -- This query joins postings with clicks to rank job postings by number of clicks, and also shows job type and country. 
-- -- It identifies the hot jobs that attracted the most user interest, and highlights in which countries those postings were trending.

select p.posting_id, p.job_type, p.country_key, count(c.user_id) as total_clicks
from {{ ref("stg_job_postings") }} p
left join {{ ref("stg_clicks_data") }} c on p.posting_id = c.posting_id
group by p.posting_id, p.job_type, p.country_key
order by total_clicks desc

-- ---------------

-- -- Query 5: Dead Jobs vs Active Jobs
-- -- This query measures engagement by comparing total postings vs those that received clicks, and calculates postings with no clicks. 
-- -- Out of ~996k postings, only 168k got clicks. Around 83% of postings are dead (no engagement). 
-- -- Another possibility is incomplete click data.

select
    count(distinct p.posting_id) as total_postings,
    count(distinct c.posting_id) as postings_with_clicks,
    count(distinct p.posting_id) - count(distinct c.posting_id) as postings_without_clicks
from {{ ref("stg_job_postings") }} p
left join {{ ref("stg_clicks_data") }} c on p.posting_id = c.posting_id

-- ---------------

-- Query 6: Clicks by Weekday
-- This query counts daily clicks and extracts the weekday (Mon, Tue, etc.) to see which days users interact most. 
-- Click activity peaks on Tuesdays and Wednesdays, suggesting users prefer mid-week for applying to jobs.

select click_date, 
       count(*) as clicks_count,
       to_char(click_date, 'DY') as weekday_short
from {{ ref("stg_clicks_data") }}
group by click_date, to_char(click_date, 'DY'), to_char(click_date, 'DAY')
order by clicks_count desc
