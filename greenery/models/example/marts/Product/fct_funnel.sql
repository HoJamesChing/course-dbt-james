{{
    config(
        materialized = 'table'
    )
}}

 {%- set event_types = dbt_utils.get_column_values(
     table = ref('fct_page_views'),
     column = 'event_type'
 ) -%}

with
session_event
as
(
    select
        session_id,
        {% for event_type in event_types %}
        sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}{% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ ref('fct_page_views') }}
    group by 
        session_id
)
select
    count(distinct session_id) as total_session,
    {% for event_type in ['page_view','add_to_cart','checkout'] %}
    sum(case when {{event_type}} > 0 then 1 else 0 end) sessions_with_{{event_type}}{% if not loop.last %},{% endif %}
    {% endfor %}
from session_event