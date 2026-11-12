# Portfolio 3 — Transactions and Concurrency

I used a temporary counter column, p3_processed_count, on the account table to compare transaction behaviour without touching the real business columns. The counter is only for this exercise. The transfer test further down does change real balances, and it puts them back at the end.

## Commit and rollback

| Stage | Counter |
| --- | --- |
| Before COMMIT | 0 |
| Uncommitted change | 1 |
| Other session before COMMIT | 0 |
| After COMMIT | 1 |
| After ROLLBACK | 1 |

The CHECK error (23514) aborted the second transaction. ROLLBACK restored the earlier committed value. READ COMMITTED kept the uncommitted change hidden from the other session.

The "Other session before COMMIT" row needs a second session, which the single-session script above does not have. Part 1 of the isolation scripts (further down) repeats it with two sessions on account 202: Session B reads 0 while Session A's change is uncommitted, and reads 1 after A commits.

## Two-session comparison

| Method | Result | Expected |
| --- | --- | --- |
| Read, calculate and write | 2 | 3 |
| SELECT FOR UPDATE | 3 | 3 |

Both sessions first read 1. Without locking, both wrote 2 and one increment was lost. With SELECT FOR UPDATE, Session B waited for Session A, read the updated value 2, and committed 3. The observed wait type was Lock. This test is only about row locking.

In these two scripts each session writes a fixed number (2) that it worked out from its earlier read. That is how I show the lost update, and it is what application code does when it reads a value, calculates, and writes back. It is not what a single `SET counter = counter + 1` does, and the next sections show the difference.

## Moving money as one transaction

The counter is only a test helper. The bank case is really about payments and balances, so I also tested a transfer on the real tables. `ONUCHUKWU_VIVIAN_301901029_P3_Transfer.sql` moves money between accounts 201 and 202 (balances 1250.75 and 3000.00, total 4250.75). A transfer is two balance updates plus two payment rows, and they must all happen or none of them.

| Step | Account 201 | Account 202 | Total | Payments |
| --- | --- | --- | --- | --- |
| Start | 1250.75 | 3000.00 | 4250.75 | 301, 302 |
| After a transfer of 100.00 (COMMIT) | 1150.75 | 3100.00 | 4250.75 | 301, 302, 401, 402 |
| Failed transfer of 5000.00, inside the transaction | not shown, the debit fails | 8100.00 | | |
| After the failed transfer (ROLLBACK) | 1150.75 | 3100.00 | 4250.75 | 301, 302, 401, 402 |

In the failed transfer I credit account 202 first, on purpose. That update works and account 202 shows 8100.00 inside the transaction. Then the debit on account 201 would take it to -3849.25, which breaks `account_nonnegative_balance` (23514). After ROLLBACK the credit is gone as well, so the total stays at 4250.75 and no money appears from nowhere. The script puts the sample data back at the end.

## Isolation: three small checks on two sessions

`ONUCHUKWU_VIVIAN_301901029_P3_Isolation_SessionA.sql` and `..._SessionB.sql` use account 202 and the helper counter. I ran them in step order in two psql sessions.

| Part | What I did | What I saw |
| --- | --- | --- |
| 1. READ COMMITTED, hidden change | A adds 1 and does not commit. B reads. A commits. B reads again. | A sees 1. B reads 0, then 1 after the commit. |
| 2. Single `counter + 1` update | A adds 1 and keeps the transaction open. B runs the same update. A commits. | B waits (wait type `Lock`, event `transactionid`, checked from a third session). When A commits B returns 2. No increment is lost. |
| 3. REPEATABLE READ | A reads 0 in a REPEATABLE READ transaction. B adds 1 and commits. A tries to add 1. | A gets `ERROR: could not serialize access due to concurrent update` (SQLSTATE 40001). After ROLLBACK, A tries again and the counter ends at 2. |

So the lost update in the table above only happens when the new value is calculated outside the database. A single atomic update waits for the lock and keeps both changes. REPEATABLE READ goes the other way: it refuses the stale write and the application has to retry.

The output of both runs is saved as text in the `output` folder. I ran everything on PostgreSQL 17.11 in a Docker container.

## Files and order

Run the Portfolio 1 schema and sample data in a fresh database, then ONUCHUKWU_VIVIAN_301901029_P3_Transactions.sql. Open two psql terminals connected to that same database. Follow steps 1–9 across SessionA.sql and SessionB.sql; run step 5 in Session A outside a transaction.

For the isolation scripts, use the same two terminals (and an optional third one for step 7) and follow steps 0–14 across the two Isolation files. The transfer script runs on its own after the Portfolio 1 schema and sample data.

- [Transactions](ONUCHUKWU_VIVIAN_301901029_P3_Transactions.sql)
- [Session A](ONUCHUKWU_VIVIAN_301901029_P3_SessionA.sql)
- [Session B](ONUCHUKWU_VIVIAN_301901029_P3_SessionB.sql)
- [Transfer](ONUCHUKWU_VIVIAN_301901029_P3_Transfer.sql) · [output](output/ONUCHUKWU_VIVIAN_301901029_P3_Transfer_Output.txt)
- [Isolation, Session A](ONUCHUKWU_VIVIAN_301901029_P3_Isolation_SessionA.sql)
- [Isolation, Session B](ONUCHUKWU_VIVIAN_301901029_P3_Isolation_SessionB.sql) · [output](output/ONUCHUKWU_VIVIAN_301901029_P3_Isolation_Output.txt)
- [Commit and rollback](screenshots/ONUCHUKWU_VIVIAN_301901029_P3_CommitRollback.png)
- [Concurrency](screenshots/ONUCHUKWU_VIVIAN_301901029_P3_ConcurrencyResult.png)

## References

- [PostgreSQL — transaction isolation](https://www.postgresql.org/docs/17/transaction-iso.html)
- [PostgreSQL — row locks](https://www.postgresql.org/docs/17/explicit-locking.html)

