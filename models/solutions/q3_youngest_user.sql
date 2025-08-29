with mini as (select min(age) as min_age from {{ ref('stg_statistics') }})
select s.first_name, s.country, s.profession, s.age
from {{ ref('stg_statistics') }} s
join mini m on s.age = m.min_age
