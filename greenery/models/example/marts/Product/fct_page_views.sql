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
    created_at,
    split_part(page_url, '/',5) as product_id
from {{ ref('stg_events') }}