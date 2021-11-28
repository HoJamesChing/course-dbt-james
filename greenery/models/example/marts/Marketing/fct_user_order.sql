{{
    config(
        materialized = 'table'
    )
}}

select
    user_id                                                                     AS user_id,
    count(distinct order_id)                                                    AS total_order_count,
    min(order_created_at)                                                       AS first_order_created_at,
    max(order_created_at)                                                       AS last_order_created_at,
    sum(order_value)                                                            AS sum_order_value,
    sum(shipping_cost)                                                          AS sum_shipping_cost,
    sum(order_value)/count(distinct order_id)                                   AS avg_order_value,
    avg(extract(hour from delivered_at - order_created_at))                     AS avg_deliver_time,
    avg(extract(hour from delivered_at - estimated_delivery_at))                AS avg_deliver_delay
from {{ ref('int_user_order') }} 
group by 
    user_id