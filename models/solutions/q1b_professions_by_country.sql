select country, count(distinct profession) as distinct_professions
from {{ ref('stg_statistics') }}
group by country
order by country
