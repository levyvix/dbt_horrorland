{{ config(
  unique_key='haunted_house_id',
  tags=['dim', 'mart']
)}}

with stg as (
  select *
  from {{ ref('stg_attractions__haunted_houses') }}
),
categories as (
  select *
  , case
        when duration_minutes < 15 then 'Short'
        when duration_minutes between 15 and 30 then 'Medium'
        else 'Long'
      end as duration_category
    , case
        when fear_level >= 4 then 'Extreme'
        when fear_level >= 3 then 'High'
        when fear_level >= 2 then 'Medium'
        else 'Low'
      end as fear_category
    , case
        when house_size_sqft >= 5000 then 'Large'
        when house_size_sqft >= 3000 then 'Medium'
        else 'Small'
      end as size_category
  from stg
)
, final as (
select
    haunted_house_id
    , house_name
    , house_status
    , theme
    , fear_level
    , duration_category
    , fear_category
    , size_category
from categories
)

select *
from final

