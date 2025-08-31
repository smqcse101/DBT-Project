select country, profession, avg(contacts) as avg_contacts
from {{ ref('stg_statistics') }}
group by country, profession
order by country, profession
