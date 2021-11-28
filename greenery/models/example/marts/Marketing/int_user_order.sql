{{
    config(
        materialized = 'table'
    )
}}

select
    u.user_id,
    o.order_id,
    o.created_at                    AS order_created_at,
    o.order_cost                    AS order_value,
    o.shipping_cost                 AS shipping_cost,
    o.order_total                   AS order_total_value,
    o.status,
    o.estimated_delivery_at,
    o.delivered_at
from {{ ref('fct_orders') }} o
left join {{ ref('dim_user') }} u on o.user_id = u.user_id