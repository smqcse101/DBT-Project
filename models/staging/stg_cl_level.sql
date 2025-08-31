select
career_level_id,
career_level_desc_en
from {{source("raw", "cl_level")}}
