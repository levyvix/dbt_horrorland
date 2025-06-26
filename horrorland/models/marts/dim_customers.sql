{{ config(
    tags=['dim', 'mart']
)}}

with

    valid_domains as (
        select domain from {{ ref('valid_domains') }}
    )

    , customer_data as (
        select
            customer_id
            , age
            , email
            , gender
            , is_vip_member
            , preferred_scare_level
            , registration_date
        from {{ ref('stg_people__customers') }}
        where dbt_valid_to is null
    )

select
    customer_id
    , age
    , email
    , {{ is_valid_email('email') }} as is_valid_email
    , gender
    , case
        when age < 18 then 'Under 18'
        when age between 18 and 24 then '18-24'
        when age between 25 and 34 then '25-34'
        when age between 35 and 49 then '35-49'
        else '50+'
    end as age_group
    , case
        when is_vip_member then 'VIP Member'
        else 'Regular Visitor'
    end as customer_category
    , preferred_scare_level
    , registration_date
from customer_data