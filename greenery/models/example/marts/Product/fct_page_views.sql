{{
    config(
        materialized = 'table'
    )
}}

select  
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at
from {{ ref('stg_events') }}