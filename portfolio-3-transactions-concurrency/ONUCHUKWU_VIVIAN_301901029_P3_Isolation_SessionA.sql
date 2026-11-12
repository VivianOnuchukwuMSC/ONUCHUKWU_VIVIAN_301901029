-- Two psql terminals on the same database, plus an optional third one for step 7.
-- Run ONUCHUKWU_VIVIAN_301901029_P3_Transactions.sql first, because it adds the helper counter.
-- This file is Session A. Follow the numbers across Session A and Session B.
-- All steps use account 202, so the counter on account 201 from the earlier test is left alone.

-- Part 1. An uncommitted change is hidden from the other session (READ COMMITTED).

-- 0. Start from zero (run outside a transaction).
UPDATE portfolio."account" SET "p3_processed_count" = 0 WHERE "account_id" = 202;

-- 1. Session A: change the counter but do not commit yet. It shows 1 here.
BEGIN ISOLATION LEVEL READ COMMITTED;
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202 RETURNING "p3_processed_count";

-- 3. Session A: commit.
COMMIT;

-- Part 2. A single UPDATE that adds one does not lose an increment.

-- 4. Reset to zero (outside a transaction).
UPDATE portfolio."account" SET "p3_processed_count" = 0 WHERE "account_id" = 202;

-- 5. Session A: add one and keep the transaction open. This holds the row lock.
BEGIN ISOLATION LEVEL READ COMMITTED;
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202 RETURNING "p3_processed_count";

-- 8. Session A: commit. Session B's waiting update now goes through.
COMMIT;

-- Part 3. REPEATABLE READ refuses a write based on an old snapshot.

-- 10. Reset to zero (outside a transaction).
UPDATE portfolio."account" SET "p3_processed_count" = 0 WHERE "account_id" = 202;

-- 11. Session A: open a REPEATABLE READ transaction and read the counter. It shows 0.
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT "p3_processed_count" FROM portfolio."account" WHERE "account_id" = 202;

-- 13. Session A: try to update the row that Session B changed after A's first read.
-- Expected: ERROR 40001, could not serialize access due to concurrent update.
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202;

-- 14. Session A: the transaction is dead, so roll back and try again from a fresh snapshot.
ROLLBACK;
BEGIN ISOLATION LEVEL REPEATABLE READ;
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202 RETURNING "p3_processed_count";
COMMIT;
