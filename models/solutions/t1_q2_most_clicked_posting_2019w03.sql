with posts_201903 as (
  select distinct posting_id
  from {{ ref('stg_job_postings') }}
  where week_id ='201903'
),

clicks as (
  select posting_id, count(*) as total_clicks   -- can use count (distinct user_id)
  from {{ ref('stg_clicks_data') }}
  group by posting_id
),

ranked as (
  select p.posting_id, c.total_clicks,
         row_number() over (order by c.total_clicks desc, p.posting_id) as rn
  from posts_201903 p
  join clicks c using (posting_id)
)


select posting_id, total_clicks
from ranked
order by total_clicks desc
--where rn = 1  -- I am using this to get the first row with maximum clicks