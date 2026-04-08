-- stg_taxi_trips.sql
-- Purpose: clean and rename raw columns, cast types, filter bad data

with source as (
    select * from raw_taxi_trips
),

cleaned as (
    select
        -- identifiers
        VendorID                                    as vendor_id,
        
        -- timestamps
        tpep_pickup_datetime                        as pickup_at,
        tpep_dropoff_datetime                       as dropoff_at,
        
        -- trip details
        passenger_count,
        trip_distance,
        PULocationID                                as pickup_location_id,
        DOLocationID                                as dropoff_location_id,
        
        -- payment
        payment_type,
        fare_amount,
        tip_amount,
        total_amount,

        -- derived
        datediff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) as trip_duration_mins

    from source
    where
        fare_amount > 0
        and trip_distance > 0
        and passenger_count > 0
        and tpep_pickup_datetime >= '2024-01-01'
        and tpep_pickup_datetime <  '2024-02-01'
)

select * from cleaned
