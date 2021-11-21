{{
  config(
    materialized='table'
  )
}}

with 
products 
as
(
    select
        *
    from {{ source('tutorial', 'products') }}
)

select
    product_id,
    name,
    price,
    quantity
from products