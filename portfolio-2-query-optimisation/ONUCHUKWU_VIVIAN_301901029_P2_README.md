# Bank / Fintech Platform — SQL queries

## 1. Show related customer, account records (up to 20).

```sql
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_type" AS "account_account_type"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;
```

| customer_customer_id | customer_full_name | account_account_id | account_account_type |
| --- | --- | --- | --- |
| 101 | Mira Chen | 201 | checking |
| 102 | Jonah Patel | 202 | savings |

## 2. Find payment records where occurred_at matches "2025-03-01T10:20:00Z" (up to 20).

```sql
SELECT * FROM portfolio."payment"
WHERE "occurred_at" IS NOT DISTINCT FROM '2025-03-01T10:20:00Z'
ORDER BY "payment_id"
LIMIT 20;
```

| payment_id | account_id | amount | direction | occurred_at | status | reference |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | 45.5 | outgoing | 2025-03-01T10:20:00+00:00 | completed | PAY-ALPHA-001 |

## 3. Count account records for each customer_id (up to 20 groups).

```sql
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
```

| customer_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.232 | 1.218, 1.232, 1.239 | Sort → Seq Scan | 139 |
| After index | 0.193 | 0.193, 0.203, 0.189 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.232 ms to 0.193 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.188..1.189 rows=25 loops=1)
  Seq Scan on payment (actual time=0.016..1.153 rows=25 loops=1)
Planning Time: 0.339 ms
Execution Time: 1.218 ms
```

### Before index, run 2

```text
Sort (actual time=1.201..1.203 rows=25 loops=1)
  Seq Scan on payment (actual time=0.014..1.166 rows=25 loops=1)
Planning Time: 0.342 ms
Execution Time: 1.232 ms
```

### Before index, run 3

```text
Sort (actual time=1.209..1.21 rows=25 loops=1)
  Seq Scan on payment (actual time=0.016..1.166 rows=25 loops=1)
Planning Time: 0.367 ms
Execution Time: 1.239 ms
```

### After index, run 1

```text
Sort (actual time=0.141..0.143 rows=25 loops=1)
  Bitmap Heap Scan on payment (actual time=0.027..0.106 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=25 loops=1)
Planning Time: 0.543 ms
Execution Time: 0.193 ms
```

### After index, run 2

```text
Sort (actual time=0.147..0.148 rows=25 loops=1)
  Bitmap Heap Scan on payment (actual time=0.029..0.104 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=25 loops=1)
Planning Time: 0.582 ms
Execution Time: 0.203 ms
```

### After index, run 3

```text
Sort (actual time=0.137..0.138 rows=25 loops=1)
  Bitmap Heap Scan on payment (actual time=0.026..0.103 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=25 loops=1)
Planning Time: 0.561 ms
Execution Time: 0.189 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run ONUCHUKWU_VIVIAN_301901029_P2_Queries.sql, then ONUCHUKWU_VIVIAN_301901029_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/ONUCHUKWU_VIVIAN_301901029_P2_QueryResults.png) · [Index comparison](screenshots/ONUCHUKWU_VIVIAN_301901029_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

