{{
  config(
    materialized='table'
  )
}}

select
    i.order_id,
    i.product_id,
    p.name AS product_name,
    p.price AS product_price,
    p.quantity AS product_inventory,
    i.quantity AS no_of_product_ordered,
    p.price * i.quantity AS total_value
from {{ref('stg_order_items')}} i
left join {{ ref('stg_products')}} p on i.product_id = p.product_id