{% test in_the_past(model, column_name) %}


   select *
   from {{ model }}
   where {{ column_name }} > now()


{% endtest %}