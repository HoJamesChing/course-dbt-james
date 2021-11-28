{{
    config(
        materialized='table'
    )
}}

select
    product_id,
    name AS product_name,
    price AS product_price,
    quantity AS product_inventory
from {{ref('stg_products')}}