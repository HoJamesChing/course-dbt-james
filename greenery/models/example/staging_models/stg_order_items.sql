{{
  config(
    materialized='table'
  )
}}

with 
order_items 
as
(
    select
        *
    from {{ source('tutorial', 'order_items') }}
)

select
    order_id,
    product_id,
    quantity
from order_items