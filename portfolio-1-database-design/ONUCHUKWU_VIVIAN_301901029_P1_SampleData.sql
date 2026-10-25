-- Fictional sample records for Bank / Fintech Platform.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at") VALUES (101, 'Mira Chen', 'mira.chen@example.test', '2025-01-12T09:30:00Z');
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at") VALUES (102, 'Jonah Patel', 'jonah.patel@example.test', '2025-02-03T14:15:00+00:00');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "currency", "balance", "opened_on", "status") VALUES (201, 101, 'checking', 'USD', 1250.75, '2025-01-15', 'active');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_type", "currency", "balance", "opened_on", "status") VALUES (202, 102, 'savings', 'USD', 3000, '2025-02-05', 'active');
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference") VALUES (301, 201, 45.5, 'outgoing', '2025-03-01T10:20:00Z', 'completed', 'PAY-ALPHA-001');
INSERT INTO portfolio."payment" ("payment_id", "account_id", "amount", "direction", "occurred_at", "status", "reference") VALUES (302, 202, 120, 'incoming', '2025-03-02T16:45:00+00:00', 'completed', NULL);
COMMIT;
