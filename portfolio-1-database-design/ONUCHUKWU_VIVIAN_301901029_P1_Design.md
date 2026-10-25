# Bank / Fintech Platform — database design

My case study records customer, account, payment.

## Users

- Customers reviewing their accounts and payment history
- Bank operations staff monitoring account activity

## Main operations

- Open an account for a customer
- Record and review account payments
- Summarize payment activity by customer

## Entities

| Entity | Information stored |
| --- | --- |
| customer | Stores customer identity separately from account records. |
| account | Stores an account and its customer foreign key; customer details remain in customer, illustrating normalized ownership. |
| payment | Records a payment against one account, including its amount, direction, time, and status. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## account

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| account_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| account_type | TEXT |  | Yes |
| currency | TEXT |  | Yes |
| balance | NUMERIC(18,2) |  | Yes |
| opened_on | DATE |  | Yes |
| status | TEXT |  | Yes |
- customer_id → customer.customer_id

## payment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| payment_id | BIGINT | PK | Yes |
| account_id | BIGINT | FK | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| direction | TEXT |  | Yes |
| occurred_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| reference | TEXT |  | No |
- account_id → account.account_id

## Relationships and business rules

- Each customer email identifies at most one customer.
- Every account must reference an existing customer through its customer_id field.
- Every payment must reference an existing account through its account_id field.
- An account balance must be zero or greater, including after a payment update.
- Every recorded payment amount must be greater than zero.
- A non-null payment reference must be unique among payments.

## Assumptions

- Each account belongs to exactly one customer, and each payment belongs to exactly one account.
- Account balances cannot be negative; a payment amount must be positive.
- Payment references are optional and, when present, are unique.
- Account is the normalization example: it stores a customer foreign key rather than repeating customer attributes.

