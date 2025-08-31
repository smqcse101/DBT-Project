select
    try_to_number(posting_id) as posting_id,
    try_to_number(user_id) as user_id,
    click_type,
    click,
    try_to_date(click_date, 'DD/MM/YYYY') as click_date,  -- adjust if needed
    try_to_number(dg_version_id) as dg_version_id,
    dg_operation_code,
    try_to_number(posting_click_trafficsource_id) as posting_click_trafficsource_id
from {{ source("raw", "clicks_data") }}

