{{
  config(
    materialized='table'
  )
}}

with
superheroes
as
(
  select  
    *
  from {{ source('tutorial', 'superheroes') }}
)
SELECT 
    id AS superhero_id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    nullif(height,-99) height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) AS weight_lbs
FROM superheroes