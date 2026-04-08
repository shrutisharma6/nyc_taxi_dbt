-- mart_location_performance.sql
-- Purpose: which pickup zones generate most revenue

with trips as (
    select * from {{ ref('int_trips_enriched') }}
)

select
    pickup_location_id,
    count(*)                            as total_trips,
    round(sum(total_amount), 2)         as total_revenue,
    round(avg(total_amount), 2)         as avg_fare,
    round(avg(trip_distance), 2)        as avg_distance,
    round(avg(tip_percentage), 2)       as avg_tip_pct

from trips
group by 1
order by total_revenue desc