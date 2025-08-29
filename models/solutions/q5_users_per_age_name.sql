select d.age_name, count(*) as user_count
from {{ ref('stg_statistics') }} s
join {{ ref('stg_age_def') }} d
  on s.age >= d.age_from
 and (s.age < d.age_until or d.age_id = 5)   -- last band inclusive
group by d.age_name
order by d.age_name
