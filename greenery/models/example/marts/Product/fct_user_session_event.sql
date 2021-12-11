{{
    config(
        materialized = 'table'
    )
}}

 {%- set event_types = dbt_utils.get_column_values(
     table = ref('fct_page_views'),
     column = 'event_type'
 ) -%}

select
    user_id,
    session_id,
    {% for event_type in event_types %}
    sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('fct_page_views') }}
group by 
    user_id,
    session_id