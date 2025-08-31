{% set as_of = var('as_of_date', '2020-07-01') %}

with eligible as (
  select *
  from {{ ref('stg_statistics') }}
  where last_visit <= to_date('{{ as_of }}')
),
maxd as (select max(last_visit) as max_visit from eligible)


select e.first_name, e.country, e.profession, e.last_visit
from eligible e
join maxd m on e.last_visit = m.max_visit
