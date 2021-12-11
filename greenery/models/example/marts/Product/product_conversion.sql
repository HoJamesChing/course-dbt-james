{{
    config(
        materialized = 'table'
    )
}}

with session_product 
as
(
    select distinct
        pv.session_id,
        pv.product_id,
        p.product_name
    from {{ ref('fct_page_views') }} pv
    left join {{ ref('dim_products') }} p on pv.product_id = p.product_id
    where 1=1
        and pv.product_id <> ''
)
, checkout_session
as
(
    select distinct
        session_id
    from {{ ref('fct_page_views') }}
    where 1=1
        and event_type = 'checkout'
)
select
    sp.product_name,
    count(distinct sp.session_id)                                   AS total_session,
    count(distinct cs.session_id)                                   AS checkout_session,
    1.0*count(distinct cs.session_id)/count(distinct sp.session_id) AS conversion_rate
from session_product sp
left join checkout_session cs on sp.session_id = cs.session_id
group by
    sp.product_name