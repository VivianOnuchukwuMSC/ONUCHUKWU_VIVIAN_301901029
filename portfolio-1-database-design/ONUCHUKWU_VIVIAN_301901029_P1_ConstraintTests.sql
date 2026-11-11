-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. duplicate customer pk. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at")
VALUES (101, 'Duplicate Vivian Key Test', 'duplicate.vivianpk@example.test', '2025-04-01T08:00:00Z');

-- 2. duplicate customer email. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at")
VALUES (1001, 'Duplicate Email Test', 'mira.chen@example.test', '2025-04-02T08:00:00Z');

-- 3. null customer name. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at")
VALUES (1002, NULL, 'null.name@example.test', '2025-04-03T08:00:00Z');

-- 4. duplicate account pk. Expected: pk_account, SQLSTATE 23505.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "currency", "balance", "opened_on", "status")
VALUES (201, 102, 'checking', 'USD', 100, '2025-04-04', 'active');

-- 5. missing account customer. Expected: fk_account_0, SQLSTATE 23503.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "currency", "balance", "opened_on", "status")
VALUES (1003, 99999, 'checking', 'USD', 100, '2025-04-05', 'active');

-- 6. negative account balance. Expected: account_nonnegative_balance, SQLSTATE 23514.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "currency", "balance", "opened_on", "status")
VALUES (1005, 101, 'checking', 'USD', -1, '2025-04-06', 'active');

-- 7. duplicate payment pk. Expected: pk_payment, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference")
VALUES (301, 202, 5, 'outgoing', '2025-04-07T08:00:00Z', 'pending', 'PAY-UNIQUE-301');

-- 8. missing payment account. Expected: fk_payment_0, SQLSTATE 23503.
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference")
VALUES (1004, 99998, 5, 'outgoing', '2025-04-08T08:00:00Z', 'pending', 'PAY-UNIQUE-1004');

-- 9. zero payment amount. Expected: payment_positive_amount, SQLSTATE 23514.
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference")
VALUES (1006, 201, 0, 'outgoing', '2025-04-09T08:00:00Z', 'pending', 'PAY-UNIQUE-1006');

-- 10. duplicate payment reference. Expected: payment_reference_if_present_unique, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference")
VALUES (1007, 202, 10, 'incoming', '2025-04-10T08:00:00Z', 'pending', 'PAY-ALPHA-001');
