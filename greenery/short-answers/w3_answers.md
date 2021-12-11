# What's our overall conversion rate?
36.1%
```sql 
SELECT
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)                                        AS count_checkouts,
    COUNT(DISTINCT session_id)                                                                      AS count_sessions,
    1.0 * SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)/COUNT(DISTINCT session_id)       AS conversion_rate
FROM dbt_james_ho.fct_page_views;
```

# What's our conversion rate by product?

A new model, product_conversion, was built to answer this question.
```sql
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
```
|  product_name     | total_session | checkout_session | conversion_rate |
|---------------------|---------------|------------------|--------------|
| Alocasia Polly      |            50 |               18 |            0.36|
| Aloe Vera           |            59 |               31 |            0.53|
| Angel Wings Begonia |            45 |               26 |            0.58|
| Arrow Head          |            73 |               41 |            0.56|
| Bamboo              |            71 |               42 |            0.59|
| Bird of Paradise    |            59 |               33 |            0.56|
| Birds Nest Fern     |            63 |               35 |            0.56|
| Boston Fern         |            53 |               29 |            0.55|
| Cactus              |            61 |               33 |            0.54|
| Calathea Makoyana   |            50 |               28 |            0.56|
| Devil's Ivy         |            60 |               27 |            0.45|
| Dragon Tree         |            65 |               36 |            0.55|
| Ficus               |            58 |               27 |            0.47|
| Fiddle Leaf Fig     |            49 |               26 |            0.53|
| Jade Plant          |            42 |               21 |            0.50|
| Majesty Palm        |            61 |               37 |            0.61|
| Money Tree          |            56 |               31 |            0.55|
| Monstera            |            51 |               31 |            0.61|
| Orchid              |            66 |               40 |            0.61|
| Peace Lily          |            60 |               33 |            0.55|
| Philodendron        |            58 |               27 |            0.47|
| Pilea Peperomioides |            57 |               34 |            0.60|
| Pink Anthurium      |            56 |               33 |            0.59|
| Ponytail Palm       |            54 |               23 |            0.43|
| Pothos              |            50 |               26 |            0.52|
| Rubber Plant        |            63 |               27 |            0.43|
| Snake Plant         |            59 |               30 |            0.51|
| Spider Plant        |            62 |               33 |            0.53|
| String of pearls    |            79 |               47 |            0.59|
| ZZ Plant            |            69 |               39 |            0.57|
