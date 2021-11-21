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
    discout discount,
    status
from promo