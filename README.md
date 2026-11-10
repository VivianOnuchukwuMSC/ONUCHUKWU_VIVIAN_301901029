# Bank / Fintech Platform

### Student Name: Onuchukwu Vivian
### Student ID: 301901029
### Institution: MIVA Open University / MIT Program

# 📌 Project Overview
This repository contains a comprehensive, multi-part database management and distributed cloud engineering portfolio. It demonstrates rigorous competency in relational database design, advanced query optimisation, transaction management & concurrency control, NoSQL document modeling, and distributed cloud architecture.

# 📂 Repository Structure
Plaintext
ONUCHUKWU_VIVIAN_301901029-main/
│
├── ONUCHUKWU_VIVIAN_301901029_FinalSummary.md    # Executive summary of the entire portfolio
├── ONUCHUKWU_VIVIAN_301901029_FinalSummary.pdf    # PDF version of the final summary
├── README.md                                      # Main project documentation
├── images/                                        # Global architecture and ER diagrams
│   └── ONUCHUKWU_VIVIAN_301901029_ERDiagram.png
│
├── portfolio-1-database-design/                   # Relational Database Design & Normalisation
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_Design.md
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_ERDiagram.md
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_Normalisation.md
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_Schema.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_SampleData.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_ConstraintTests.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P1_README.md
│   └── screenshots/
│       └── ONUCHUKWU_VIVIAN_301901029_P1_DatabaseResults.png
│
├── portfolio-2-query-optimisation/               # Performance Tuning & Execution Plans
│   ├── ONUCHUKWU_VIVIAN_301901029_P2_Queries.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P2_Optimisation.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P2_README.md
│   └── screenshots/
│       ├── ONUCHUKWU_VIVIAN_301901029_P2_IndexComparison.png
│       └── ONUCHUKWU_VIVIAN_301901029_P2_QueryResults.png
│
├── portfolio-3-transactions-concurrency/         # ACID Compliance & Concurrency Control
│   ├── ONUCHUKWU_VIVIAN_301901029_P3_Transactions.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P3_SessionA.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P3_SessionB.sql
│   ├── ONUCHUKWU_VIVIAN_301901029_P3_README.md
│   └── screenshots/
│       ├── ONUCHUKWU_VIVIAN_301901029_P3_CommitRollback.png
│       └── ONUCHUKWU_VIVIAN_301901029_P3_ConcurrencyResult.png
│
├── portfolio-4-nosql/                            # Document-Based NoSQL Modeling (MongoDB)
│   ├── ONUCHUKWU_VIVIAN_301901029_P4_MongoDB.js
│   ├── ONUCHUKWU_VIVIAN_301901029_P4_README.md
│   └── screenshots/
│       └── ONUCHUKWU_VIVIAN_301901029_P4_DocumentsAndQueries.png
│
└── portfolio-5-distributed-cloud/                # Scalable & Fault-Tolerant Cloud Architecture
    ├── ONUCHUKWU_VIVIAN_301901029_P5_README.md
    └── screenshots/
        └── ONUCHUKWU_VIVIAN_301901029_P5_ProposedDesign.png
        
## 🛠 Portfolio Component Breakdown
#### 1. Relational Database Design (portfolio-1-database-design/)
Focus: Conceptual mapping, logical design, and normalisation up to Third Normal Form (3NF).

Key Artifacts: DDL schemas (_P1_Schema.sql), dummy instantiation datasets (_P1_SampleData.sql), and rigid constraint test scripts (_P1_ConstraintTests.sql).

Highlights: Ensures data integrity via foreign keys, check constraints, and custom validation rules.

# 2. Query Optimisation & Indexing (portfolio-2-query-optimisation/)
Focus: Identifying bottlenecks in complex joins, aggregate queries, and subqueries.

Key Artifacts: Unoptimised vs. tuned scripts (_P2_Queries.sql, _P2_Optimisation.sql) backed by execution plan screenshots.

Highlights: Implements strategic composite and covering indexes to drastically minimize cost metrics and execution time.

# 3. Transactions & Concurrency Control (portfolio-3-transactions-concurrency/)
Focus: Ensuring ACID properties, managing isolation levels, and diagnosing concurrency anomalies (e.g., Dirty Reads, Non-Repeatable Reads, Phantoms, Deadlocks).

Key Artifacts: Concurrent simulation sessions (_P3_SessionA.sql, _P3_SessionB.sql) and transaction scripts.

Highlights: Illustrates fine-grained control over locks, commits, and rollbacks.

# 4. NoSQL Document Modeling (portfolio-4-nosql/)
Focus: Transitioning from relational paradigms to flexible schema design using MongoDB.

Key Artifacts: Native aggregation pipeline scripts and collection queries (_P4_MongoDB.js).

Highlights: Optimized embedding versus referencing strategies tailored for high read-throughput web and mobile workloads.

# 5. Distributed Cloud Architecture (portfolio-5-distributed-cloud/)
Focus: Designing resilient, highly available, and horizontally scalable cloud infrastructures.

Key Artifacts: Architectural blueprints and structured documentation (_P5_README.md).

Highlights: Explores multi-region database replication, sharding strategies, load balancing, and fault tolerance.

### 🚀 Getting Started / Execution Instructions
Prerequisites
A running relational database engine (e.g., PostgreSQL or MySQL) for Portfolio parts 1 to 3.

MongoDB Shell (mongosh) or MongoDB Compass for Portfolio part 4.

### Step-by-Step Execution
Setup Relational Schema:

SQL
-- Run in your SQL client
\i portfolio-1-database-design/ONUCHUKWU_VIVIAN_301901029_P1_Schema.sql
\i portfolio-1-database-design/ONUCHUKWU_VIVIAN_301901029_P1_SampleData.sql
Test Constraints:

SQL
\i portfolio-1-database-design/ONUCHUKWU_VIVIAN_301901029_P1_ConstraintTests.sql
Run Query Optimisation Tests:
Execute scripts inside portfolio-2-query-optimisation/ with execution plans (EXPLAIN / EXPLAIN ANALYZE) enabled.

Execute NoSQL Scripts:

Bash
mongosh < portfolio-4-nosql/ONUCHUKWU_VIVIAN_301901029_P4_MongoDB.js

# 📄 License & Academic Integrity
This work was completed independently as part of coursework requirements at MIVA Open University. All rights reserved.

The portfolio uses fictional records for Bank / Fintech Platform.

- [Portfolio 1](portfolio-1-database-design/)
- [Portfolio 2](portfolio-2-query-optimisation/)
- [Portfolio 3](portfolio-3-transactions-concurrency/)
- [Portfolio 4](portfolio-4-nosql/)
- [Portfolio 5](portfolio-5-distributed-cloud/)

[Final summary](ONUCHUKWU_VIVIAN_301901029_FinalSummary.md) · [PDF](ONUCHUKWU_VIVIAN_301901029_FinalSummary.pdf)
