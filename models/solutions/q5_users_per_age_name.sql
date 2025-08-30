select d.age_name, count(*) as user_count
from {{ ref('stg_statistics') }} s
join {{ ref('stg_age_def') }} d
  on s.age >= d.age_from
 and (s.age <= d.age_until)   
group by d.age_name
order by d.age_name


--Problems in the tables I have found is there is no age bin for Hannah because her age is 17.
--The second problem is in AGE_UNTIL coloumn of AGE_DIFF table we have value 36 which should be 35 actually.
-- For that reason we get two records for Paula CH as her age is 36 and appears in two bins