-- Show related customer, account records (up to 20).
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_type" AS "account_account_type"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_type" AS "account_account_type"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;

-- Find payment records where occurred_at matches "2025-03-01T10:20:00Z" (up to 20).
SELECT * FROM portfolio."payment"
WHERE "occurred_at" IS NOT DISTINCT FROM '2025-03-01T10:20:00Z'
ORDER BY "payment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."payment"
WHERE "occurred_at" IS NOT DISTINCT FROM '2025-03-01T10:20:00Z'
ORDER BY "payment_id"
LIMIT 20;

-- Count account records for each customer_id (up to 20 groups).
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "customer_id", count(*) AS record_count
FROM portfolio."account"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
