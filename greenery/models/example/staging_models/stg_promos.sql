{{
  config(
    materialized='table'
  )
}}

with 
promo 
as
(
    select
        *
    from {{ source('tutorial', 'promos') }}
)

select
    promo_id,
    discout AS discount,
    status
from promo