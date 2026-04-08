-- int_trips_enriched.sql
-- Purpose: add business logic, categorizations

with trips as (
    select * from {{ ref('stg_taxi_trips') }}   -- ← this is how dbt handles dependencies
),

enriched as (
    select
        *,

        -- time categorization
        case
            when hour(pickup_at) between 7 and 9   then 'Morning Rush'
            when hour(pickup_at) between 17 and 19  then 'Evening Rush'
            when hour(pickup_at) between 22 and 23
              or hour(pickup_at) between 0 and 4    then 'Late Night'
            else 'Off Peak'
        end as time_of_day,

        -- trip size categorization
        case
            when trip_distance < 1    then 'Short'
            when trip_distance < 5    then 'Medium'
            when trip_distance < 15   then 'Long'
            else 'Very Long'
        end as trip_category,

        -- payment type label
        case payment_type
            when 1 then 'Credit Card'
            when 2 then 'Cash'
            when 3 then 'No Charge'
            when 4 then 'Dispute'
            else 'Unknown'
        end as payment_method,

        -- revenue metrics
        round(fare_amount / nullif(trip_distance, 0), 2)    as revenue_per_mile,
        round(tip_amount / nullif(fare_amount, 0) * 100, 2) as tip_percentage

    from trips
)

select * from enriched