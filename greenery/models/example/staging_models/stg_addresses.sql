{{
  config(
    materialized='table'
  )
}}

with 
addresses 
as
(
    select
        *
    from {{ source('tutorial', 'addresses') }}
)

select
    address_id,
    address,
    zipcode,
    state,
    country
from addresses