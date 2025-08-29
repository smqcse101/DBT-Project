select
  first_name,
  country,
  profession,
  cast(age as number) as age,
  to_date(last_visit, 'DD.MM.YYYY') as last_visit,
  cast(contacts as number) as contacts
from {{ ref('statistics') }}
