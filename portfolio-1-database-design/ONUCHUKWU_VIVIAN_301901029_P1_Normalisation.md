# Bank / Fintech Platform — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| customer_id | account records (list) |
| --- | --- |
| 101 | [201] |
| 102 | [202] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| account.account_id | account.customer_id | account.account_type | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | checking | 101 | Mira Chen |
| 202 | 102 | savings | 102 | Jonah Patel |

Key: account_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## account_example

| account.account_id | account.customer_id | account.account_type | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | checking | 101 | Mira Chen |
| 202 | 102 | savings | 102 | Jonah Patel |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | full_name | email | created_at |
| --- | --- | --- | --- |
| 101 | Mira Chen | mira.chen@example.test | 2025-01-12T09:30:00+00:00 |
| 102 | Jonah Patel | jonah.patel@example.test | 2025-02-03T14:15:00+00:00 |

## account

| account_id | customer_id | account_type | currency | balance | opened_on | status |
| --- | --- | --- | --- | --- | --- | --- |
| 201 | 101 | checking | USD | 1250.75 | 2025-01-15 | active |
| 202 | 102 | savings | USD | 3000 | 2025-02-05 | active |

## payment

| payment_id | account_id | amount | direction | occurred_at | status | reference |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | 45.5 | outgoing | 2025-03-01T10:20:00+00:00 | completed | PAY-ALPHA-001 |
| 302 | 202 | 120 | incoming | 2025-03-02T16:45:00+00:00 | completed | NULL |

## Dependencies

- customer: (customer_id) → full_name, email, created_at
- account: (account_id) → customer_id, account_type, currency, balance, opened_on, status
- payment: (payment_id) → account_id, amount, direction, occurred_at, status, reference

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
