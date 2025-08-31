{{ config(materialized='view') }}

with src as (
  select * from {{ source('raw','postings_data') }}
)
select
  try_to_number(posting_id)                                  as posting_id,
  week_id,
  try_to_date(creation_date, 'DD/MM/YYYY')                   as creation_date,
  job_type,
  editor_id,
  upper(country_key)                                         as country_key,
  industry,
  try_to_number(category_id)                                 as category_id,
  try_to_number(career_level_id)                             as career_level_id,
  try_to_number(consumer_id)                                 as consumer_id,
  try_to_number(order_id)                                    as order_id,
  try_to_number(dg_version_id)                               as dg_version_id
from src
