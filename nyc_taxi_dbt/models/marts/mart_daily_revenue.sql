-- mart_daily_revenue.sql
-- Purpose: daily revenue summary for BI/analytics consumption

with trips as (
    select * from {{ ref('int_trips_enriched') }}
),

daily_summary as (
    select
        date_trunc('day', pickup_at)::date      as trip_date,
        time_of_day,
        payment_method,
        trip_category,

        count(*)                                as total_trips,
        sum(total_amount)                       as total_revenue,
        avg(total_amount)                       as avg_fare,
        avg(trip_duration_mins)                 as avg_duration_mins,
        avg(trip_distance)                      as avg_distance_miles,
        avg(tip_percentage)                     as avg_tip_pct,
        sum(passenger_count)                    as total_passengers

    from trips
    group by 1, 2, 3, 4
)

select * from daily_summary