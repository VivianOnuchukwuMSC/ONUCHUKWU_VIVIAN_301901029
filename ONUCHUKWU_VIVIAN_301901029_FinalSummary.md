# Bank / Fintech Platform:<br/> 
**Advanced Database Systems Portfolio**

**Student:** Vivian Onuchukwu<br/> 
**Student ID:** 301901029<br/> 
**Programme:** Masters In Information Technology (MIT), Miva Open University<br/> 
**Module:** MIT 8103 Advanced Database Systems<br/> 
**Repository:** https://github.com/VivianOnuchukwuMSC/ONUCHUKWU_VIVIAN_301901029

---

# 1. Introduction and case study

My case study is a Bank / Fintech Platform. It serves two groups of users: **customers,** who review their accounts and payment history, and **bank operations staff,** who monitor account activity. It supports three operations:<br/>

**1.** Open an account for a customer.<br/>
**2** Record and review account payments.<br/>
**3** Summarise payment activity by customer.<br/>

I used this one case across all five portfolios so that each stage builds on the previous one: relational design (P1), query optimisation (P2), transactions and concurrency (P3), a document model (P4), and a distributed deployment proposal (P5). All data is fictional. Names and balances are invented, and e-mail addresses use the reserved example.test domain.

**What was executed and what was not.** Portfolios 1 to 4 were run (PostgreSQL 17 and MongoDB) and their results are reported below. Portfolio 5 is the permitted design-discussion option. No cloud service, replica set, failover, sharding or recovery test was run for it.<br/>

## Portfolio 1: Database Design and Modelling

I organised the relational design into 3 tables. Primary keys identify records, foreign keys preserve the links, and checks enforce the stated business rules. A non-null payment reference must be unique among payments. The normalisation examples show the sample data at 1NF, 2NF and 3NF. All 10 deliberately invalid inserts were rejected without changing the valid sample rows.

![Bank / Fintech Platform ER diagram](images/ONUCHUKWU_VIVIAN_301901029_ERDiagram.png)

Figure 1. Tables, keys and relationships. PK: primary key; FK: foreign key; UK: unique value.

<!-- PAGE BREAK -->

## Portfolio 2: Query Processing and Optimisation

I ran three SQL queries against the sample records. The join returned 2 rows and included Mira Chen with checking. For the index comparison, I used 25,000 separate performance rows. The median lookup time changed from 1.232 ms to 0.193 ms. Both phases returned the same records. The measured plan used the new index. These timings apply to this lookup and environment.

## Portfolio 3: Transactions and Concurrency

I used a temporary counter on account to test COMMIT, ROLLBACK and READ COMMITTED isolation. The uncommitted update remained hidden from the other session, and ROLLBACK restored the earlier committed value. Without locking, two increments left the counter at 2. With SELECT FOR UPDATE, Session B waited for Session A and the final value was 3. The helper is confined to this exercise; the case's original business fields stay unchanged.

## Portfolio 4: NoSQL and Advanced Data Models

I used account_events for the case's event documents. MongoDB inserted 4 sample events and returned the expected results for 4 queries. Validation rejected an invalid date type and a duplicate event ID. Embedded snapshots keep related details with an event, while the details field can differ by event type. These are fictional events; PostgreSQL continues to enforce its relational rules.

## Repository and evidence

https://github.com/VivianOnuchukwuMSC/ONUCHUKWU_VIVIAN_301901029

The portfolio folders contain the SQL and JavaScript, explanations, query plans, result tables and screenshots.


<!-- PAGE BREAK -->

## Portfolio 5: Distributed and Cloud Database Exercise

I proposed three MongoDB replica members across separate failure zones. The discussion covers primary elections, majority acknowledgement, secondary lag and sharding trade-offs for account_events. Replication supports availability, while backups address recovery. PostgreSQL needs its own availability plan. This is the permitted discussion option; no live replica set or failover test was deployed.

## Individual reflection

I kept customer, account, payment in separate tables so their details could be maintained without repeating them in every related record. A non-null payment reference must be unique among payments. The constraint tests check this alongside the required values and record links. One issue illustrated by the two-session exercise is that both sessions can read the same value before either update is committed. Locking the row before reading preserves both increments. The index comparison also shows why I need to check the execution plan as well as the final answer: the same result can require different amounts of database work.

## AI-use declaration

I used GitHub Copilot and the portfolio generator to help prepare the database model, scripts and explanations. The generator ran the PostgreSQL and MongoDB exercises, checked their outputs and captured the result images.  I remain responsible for checking and explaining the submitted work.

## References

- [PostgreSQL: constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)
- [PostgreSQL: EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)
- [PostgreSQL: isolation](https://www.postgresql.org/docs/17/transaction-iso.html)
- [PostgreSQL: row locks](https://www.postgresql.org/docs/17/explicit-locking.html)
- [MongoDB: data modelling](https://www.mongodb.com/docs/manual/data-modeling/)
- [MongoDB: replication](https://www.mongodb.com/docs/manual/replication/)
- [MongoDB: sharding](https://www.mongodb.com/docs/manual/sharding/)
- [Mermaid: ER diagrams](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)

