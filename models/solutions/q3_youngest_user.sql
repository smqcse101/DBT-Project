with minimum_age_table as (select min(age) as min_age from {{ ref('stg_statistics') }})

select s.first_name, s.country, s.profession, s.age
from {{ ref('stg_statistics') }} s
join minimum_age_table m on s.age = m.min_age



-- select * from stg_statistics
-- where  age = (select min(age) from {{ ref('stg_statistics') }})