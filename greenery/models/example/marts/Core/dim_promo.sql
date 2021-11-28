{{
    config(
        materialized='table'
    )
}}

select 
    promo_id,
    discount AS promo_discount,
    status AS promo_status
from {{ ref('stg_promos') }}