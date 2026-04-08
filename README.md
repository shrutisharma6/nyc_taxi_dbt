# 🚕 NYC Taxi Analytics — dbt + DuckDB

An end-to-end data transformation project built with **dbt Core** and **DuckDB**, modeling
2.9M+ NYC Yellow Taxi trip records across a production-style layered architecture.

Built to demonstrate real-world data engineering practices — clean separation of layers,
data quality testing, and auto-generated documentation with lineage tracking.

---

## 🏗️ Architecture

raw_data (Parquet)
      ↓
staging (clean + rename)
      ↓
intermediate (business logic + enrichment)
      ↓
marts (analytics-ready tables)

---

## 📐 Project Structure

models/
├── staging/          # Cleans raw columns, casts types, filters invalid records
├── intermediate/     # Adds business logic — time categories, trip size, payment labels
└── marts/            # Final aggregated tables ready for BI consumption

---

## 📊 Models

| Model | Layer | Description |
|---|---|---|
| `stg_taxi_trips` | Staging | Cleaned and renamed raw trip records |
| `int_trips_enriched` | Intermediate | Adds time-of-day, trip category, payment label, revenue metrics |
| `mart_daily_revenue` | Mart | Daily revenue aggregated by time, payment method, trip category |
| `mart_location_performance` | Mart | Revenue and trip metrics by pickup location |

---

## ✅ Data Quality Tests

- `not_null` checks on all critical columns
- `accepted_values` test on payment type codes
- `unique` constraint on location IDs in mart layer
- Custom singular test asserting no negative revenue exists in final mart

Run tests:
\```bash
dbt test
\```

---

## 📖 Documentation & Lineage

Auto-generated dbt docs with full column descriptions and DAG lineage:

\```bash
dbt docs generate
dbt docs serve
\```

---

## 🛠️ Tech Stack

- **dbt Core** — transformation framework
- **DuckDB** — local analytical database
- **Python** — raw data loading
- **NYC TLC Dataset** — Yellow Taxi trip records, Jan 2024

---

## 🚀 How to Run

**1. Clone the repo**
\```bash
git clone https://github.com/shrutisharma6/nyc-taxi-dbt.git
cd nyc-taxi-dbt
\```

**2. Set up virtual environment**
\```bash
python -m venv dbt-env
source dbt-env/bin/activate
pip install dbt-duckdb duckdb
\```

**3. Configure profiles.yml**
\```bash
cp profiles.yml.example ~/.dbt/profiles.yml
# Edit the path to point to your local project directory
\```

**4. Download dataset**
\```bash
mkdir raw_data
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet \
     -O raw_data/yellow_tripdata_2024-01.parquet
\```

**5. Load raw data**
\```bash
python load_raw.py
\```

**6. Run dbt pipeline**
\```bash
dbt debug       # verify connection
dbt run         # build all models
dbt test        # run data quality tests
dbt docs generate && dbt docs serve   # view lineage docs
\```

---

## 📁 Dataset

[NYC TLC Trip Record Data](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page)
— Yellow Taxi trips, January 2024 (~2.9M records)
