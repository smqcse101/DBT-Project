select count(distinct profession) as total_distinct_professions
from {{ ref('stg_statistics') }}
