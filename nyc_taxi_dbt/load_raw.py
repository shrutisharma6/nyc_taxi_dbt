import duckdb

con = duckdb.connect("dev.duckdb")

con.execute(r"""
    CREATE TABLE IF NOT EXISTS raw_taxi_trips AS
    SELECT * FROM read_parquet('raw_data\yellow_tripdata_2024-01.parquet')
""")

print(f"Loaded {con.execute('SELECT COUNT(*) FROM raw_taxi_trips').fetchone()[0]:,} rows")
con.close()