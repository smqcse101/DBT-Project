select profession, avg(age) as avg_age
from {{ ref('stg_statistics') }}
group by profession
order by profession
