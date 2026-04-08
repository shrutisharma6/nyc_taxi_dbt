-- This test FAILS if any rows return — i.e. if revenue is ever negative
select *
from {{ ref('mart_daily_revenue') }}
where total_revenue < 0