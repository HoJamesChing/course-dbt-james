# What's our overall conversion rate?
36.1%
'''sql
SELECT
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)                                        AS count_checkouts,
    COUNT(DISTINCT session_id)                                                                      AS count_sessions,
    1.0 * SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)/COUNT(DISTINCT session_id)       AS conversion_rate
FROM dbt_james_ho.fct_page_views;
'''

# What's our conversion rate by product?

A new model was built to answer this question.
'''sql
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
order by
    sp.product_name
'''