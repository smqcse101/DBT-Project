{{ config(materialized='view') }}

-- 1) Classic type of query where we are adding number of postings per (career_level_id, week_id) So I am using group by here.
with weekly_inventory as (
  select
    career_level_id,
    week_id,
    count(*) as postings
  from {{ ref('stg_job_postings') }}           
  group by career_level_id, week_id
),

-- 2) Since the question asks about weekly development we have to see how postings are changing in the future i.e we 
--se the increase in the postings. Sometimes there could also be a fall in posting for a particular career level. Hence we use
-- here window functions.
weekly_wow as (
  select
    career_level_id,
    week_id,
    postings,
    postings
      - lag(postings) over (
          partition by career_level_id
          order by to_number(week_id)          -- ensures correct temporal ordering
        ) as wow_change
  from weekly_inventory
),

-- 3) Join readable career level names to english explanaiton of the career level.
career_level_names as (
  select
    career_level_id,
    career_level_desc_en as career_level_name
  from {{ ref('stg_cl_level') }}               -- staging model for career level dimension
),

-- 4) Sum only positive WoW changes to measure total growth. Growth could also be measured by checking average value in 4 weeks or 
-- we could just also check for a spike in the value with highest posting. but to get an overall good picture I have added
--the cummulative value for growth.
growth_by_level as (
  select
    w.career_level_id,
    n.career_level_name,
    sum(greatest(w.wow_change, 0)) as total_weekly_growth
  from weekly_wow w
  left join career_level_names n
    on n.career_level_id = w.career_level_id
  group by w.career_level_id, n.career_level_name
)

-- 5) Final answer: career levels ranked by cumulative weekly growth
select
  career_level_id,
  coalesce(career_level_name, 'N/A') as career_level_name,
  total_weekly_growth
from growth_by_level
order by total_weekly_growth desc, career_level_id
