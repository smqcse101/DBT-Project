select
  cast(age_id as number) as age_id,
  age_name,
  cast(age_from as number) as age_from,
  cast(age_until as number) as age_until
from {{ ref('age_def') }}
