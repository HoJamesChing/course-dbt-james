{% macro get_event_types() %}
{% set query %}
select distinct
    event_type
from {{ ref('fct_page_views') }}
order by 1
{% endset %}

{% set results = run_query(query) %}

{% if execute %}

{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}

{% endif %}

{{ return(results_list) }}

{%endmacro %}