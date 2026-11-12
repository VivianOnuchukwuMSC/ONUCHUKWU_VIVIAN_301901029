-- Session B for the isolation exercise. Follow the numbers across Session A and Session B.
-- Same database, same account 202, second psql terminal.

-- 2. Session B: read the counter while Session A's change is still uncommitted.
-- Expected: 0, because READ COMMITTED only shows committed data.
SELECT "p3_processed_count" FROM portfolio."account" WHERE "account_id" = 202;

-- (after Session A commits in step 3)
-- 3b. Session B: read again. Expected: 1.
SELECT "p3_processed_count" FROM portfolio."account" WHERE "account_id" = 202;

-- 6. Session B: add one while Session A still holds the row lock.
-- This statement waits. Nothing is returned until Session A commits in step 8.
BEGIN ISOLATION LEVEL READ COMMITTED;
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202 RETURNING "p3_processed_count";

-- 7. Optional third terminal, run while step 6 is waiting. It shows that B is waiting on a lock:
-- SELECT pid, state, wait_event_type, wait_event, left(query, 70) AS query
-- FROM pg_stat_activity
-- WHERE datname = current_database() AND wait_event_type = 'Lock';

-- 9. Session B: after A commits the update finishes. It re-reads the committed row, so it returns 2.
COMMIT;
SELECT "p3_processed_count" FROM portfolio."account" WHERE "account_id" = 202;

-- 12. Session B: while Session A sits in its REPEATABLE READ transaction, change the same row and commit.
UPDATE portfolio."account" SET "p3_processed_count" = "p3_processed_count" + 1 WHERE "account_id" = 202 RETURNING "p3_processed_count";
