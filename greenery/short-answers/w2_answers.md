<h3>1. What is our user repeat rate?</h3>
Repeat Rate = Users who purchased 2 or more times / users who purchased </p>

```sql
--users who purchased 2 or more times

select 
    count(*) 
from (
        select 
            user_id,
            count(order_id) as no_of_orders 
        from dbt_james_ho.stg_orders 
        group by 
            user_id 
        having 
            count(order_id)>1
) repeat_user
;
-- # 103


--total users
select
    count(distinct user_id)
from dbt_james_ho.stg_orders
where order_id is not null
;

-- #128
```

>Repeat rate = 103/128 = 80%


<h3>2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?</h3>

Delivery time is definitely an important factor of user satification. Knowing the average time between order created and order delivered, estima and delivered gives a picture of how we manage a customer's expectation.</p>
Also, from the data, it seems that a customer who spends averagely more on one single order is more likely to come back again.

<h3>3. Why did you organize the models in the way you did?</h3>
The core folder contains the centric data of the whole business in a most granular level. They are used as the 'source' table of intermediate tables in other folders.</p>
The intermediate tables, which start with int_, are the tables that used to apply business logic and aggregation. They are really one step before doing aggregation so we still have that granularity in each business unit's folder.</p>
Fact and dim tables are normally exposed to end users. Some of them have been applied aggregation and therefore have lost some granularity of information. Their purpose is to answer business questions with non/least data transformation effort.</p>

<h3>4. What assumptions are you making about each model? (i.e. why are you adding each test?)</h3>
I only managed to add tests in staging models. Except baisc validations on PKs, ie not_null and unique, I also tested if all the timestamp like created_at, delivered_at are in the past to make sure we don't get weird futuristic data. Positive values test is also applied to most of the numeric columns.</p> 
In addition, relationship test is also applied to FK in each table.</p>

<h3>5. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?</h3>
<p>
There's one row in order table that has negative value of order_total_value, which is not expected. However, since removing this row by adding a where clasue will lead to another failure in the relationship test, I leave it as it is and accept there's one noisy data point in order table.
