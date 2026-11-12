-- Moving money between two accounts as one transaction.
-- Run the Portfolio 1 schema and sample data first. No helper column is needed here.
-- The last block puts the sample data back, so the script can be run again.

-- Before: balances and the total across the two accounts.
SELECT "account_id", "balance" FROM portfolio."account" WHERE "account_id" IN (201, 202) ORDER BY "account_id";
SELECT sum("balance") AS total_before FROM portfolio."account" WHERE "account_id" IN (201, 202);

-- 1. A transfer that works: 100.00 from account 201 to account 202.
-- The two balance updates and the two payment rows must all happen together or not at all.
BEGIN;
UPDATE portfolio."account" SET "balance" = "balance" - 100.00 WHERE "account_id" = 201;
UPDATE portfolio."account" SET "balance" = "balance" + 100.00 WHERE "account_id" = 202;
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference")
VALUES (401, 201, 100.00, 'outgoing', now(), 'completed', 'TRF-0001-OUT'),
       (402, 202, 100.00, 'incoming', now(), 'completed', 'TRF-0001-IN');
COMMIT;

SELECT "account_id", "balance" FROM portfolio."account" WHERE "account_id" IN (201, 202) ORDER BY "account_id";
SELECT sum("balance") AS total_after_transfer FROM portfolio."account" WHERE "account_id" IN (201, 202);

-- 2. A transfer that fails: 5000.00 from account 201, which does not have that much.
-- I credit account 202 first on purpose. That update succeeds inside the transaction,
-- then the debit breaks the balance >= 0 check. ROLLBACK should undo the credit as well.
-- ON_ERROR_STOP is off so psql keeps going after the error and the ROLLBACK can run.
\set ON_ERROR_STOP off
BEGIN;
UPDATE portfolio."account" SET "balance" = "balance" + 5000.00 WHERE "account_id" = 202;
SELECT "account_id", "balance" AS balance_inside_transaction FROM portfolio."account" WHERE "account_id" = 202;
UPDATE portfolio."account" SET "balance" = "balance" - 5000.00 WHERE "account_id" = 201;
ROLLBACK;
\set ON_ERROR_STOP on

-- After the failed transfer nothing should have changed.
SELECT "account_id", "balance" FROM portfolio."account" WHERE "account_id" IN (201, 202) ORDER BY "account_id";
SELECT sum("balance") AS total_after_failed_transfer FROM portfolio."account" WHERE "account_id" IN (201, 202);
SELECT "payment_id" FROM portfolio."payment" ORDER BY "payment_id";

-- Put the sample data back.
BEGIN;
DELETE FROM portfolio."payment" WHERE "payment_id" IN (401, 402);
UPDATE portfolio."account" SET "balance" = 1250.75 WHERE "account_id" = 201;
UPDATE portfolio."account" SET "balance" = 3000 WHERE "account_id" = 202;
COMMIT;
