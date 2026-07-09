# FitZone Gym Management System 🏋️

A relational Database Management System (DBMS) project that models the core operations of a full-service gym — memberships, subscription plans, trainers, walk-in retail sales, equipment inventory, invoicing, refunds, and attendance tracking.

This repository contains the database design artifacts (ERD, relational schema, BCNF normalization report), the SQL DDL, phase-wise sample data (DML), and a structured set of analytical SQL queries (DQL) used to derive operational insights from the schema.

## 📁 Repository Contents

| File | Description |
|---|---|
| `DDL_FOR_GYM.sql` | SQL `CREATE TABLE` statements defining the core database schema |
| `DML_Phase1_Location.sql` | Seed data for pincode/district/state locations |
| `DML_Phase2_Plan_Category_Equipment.sql` | Seed data for membership plans, equipment categories, equipment, and plan-equipment access mapping |
| `DML_Phase3_People.sql` | Seed data for trainers, walk-in customers, and members |
| `DML_Phase4_Items_Buyers_Subscription_Attendance.sql` | Seed data for retail items, the polymorphic buyer mapping, subscriptions, cancellations, and attendance |
| `DML_Phase5_Invoice_InvoiceDetails_Refund.sql` | Seed data for invoices, invoice line items, and refunds |
| `Complet_DQL_Script.sql` | 40 analytical SQL queries spanning filtering, aggregation, joins, set operations, subqueries, and relational division |
| `FitZone_ER_Diagram.pdf` | Entity-Relationship Diagram of the system |
| `FitZone_Relational_Schema.pdf` | Relational schema / mapping documentation |
| `FitZone_BCNF_Report_Cleaned.pdf` | Formal BCNF verification of every table in the schema |

## 🧱 Database Schema

The schema is organized around the following core entities:

**Infrastructure**
- `Location` — pincode-to-district/state lookup, extracted to eliminate transitive dependencies in `Member` and `Trainer`

**People**
- `Member` — registered gym members (demographics, contact, address)
- `Trainer` — gym trainers/coaches (rating, commission rate, experience)
- `WalkInCustomer` — retail-only customers with no gym membership

**Membership**
- `Plan` — subscription plan tiers (Silver, Gold, Platinum, Diamond), each with duration, price, and discount
- `Subscription` — a member's active/past subscription to a plan, optionally assigned to a trainer, with point-in-time `BillingAmount`
- `Cancellation` — cancellation records tied 1:1 to a subscription (reason, penalty, refund status)
- `Attendance` — gym check-in log keyed on `(SubscriptionID, CheckInTimeStamp)`

**Inventory**
- `Category` — controlled list of equipment category names
- `Equipment` — physical gym equipment, classified by category
- `PlanEquipmentAccess` — many-to-many junction resolving which plans unlock which equipment categories
- `Items` — retail products (supplements, gear, accessories) with stock and pricing

**Commerce**
- `Buyer` — polymorphic supertype over `Member` / `WalkInCustomer` / `Trainer`, enforced via an exclusive `CHECK` constraint, so `Invoice` only needs a single `BuyerID`
- `Invoice` — retail sale invoices
- `InvoiceDetails` — line items per invoice, storing point-in-time `UnitPrice` and `DiscountApplied`
- `Refund` — refund records tied to a specific invoice line item

Foreign keys tie subscriptions to members/trainers/plans, invoices to buyers, invoice details to items, and refunds/cancellations back to their parent transaction — enforcing referential integrity throughout.

The full schema (16 relations) has been formally verified to satisfy **Boyce–Codd Normal Form (BCNF)** — see `FitZone_BCNF_Report_Cleaned.pdf` for the table-by-table functional dependency analysis and the key design decisions (e.g. the `Location` extraction, the `Buyer` polymorphic abstraction, and point-in-time pricing) that make this possible.

See `FitZone_ER_Diagram.pdf` for the full entity-relationship diagram and `FitZone_Relational_Schema.pdf` for the finalized relational mapping.

## 🔍 Example Analytical Queries

`Complet_DQL_Script.sql` includes 40 ready-to-run queries organized into 10 difficulty levels, including:

- Members sorted by newest joiners, and the top 3 most expensive plans
- Total expected revenue from currently active subscriptions
- Pincodes with more than 3 resident members
- Which trainer is assigned to which member, and for what plan (multi-join)
- What equipment categories a given plan grants access to
- A complete polymorphic purchase receipt showing the buyer's name whether they're a member, walk-in customer, or trainer (`COALESCE` across three tables)
- Plans with zero subscriptions, and walk-in customers who never made a purchase (outer joins)
- A single deduplicated list of every email address in the system (`UNION`)
- Pincodes where both a member and a trainer live (`INTERSECT`)
- Plans that grant access to **every** equipment category, and members who have bought **every** item in the Supplements category (relational division)
- Trainers ranked by total revenue generated from their managed subscriptions
- Members with active subscriptions who haven't checked in within the last 30 days (churn risk)

These queries make heavy use of joins, correlated subqueries, set operations, and aggregate functions, and are written against **PostgreSQL** syntax (e.g. `SET SEARCH_PATH`, `INTERVAL`).

## 🛠️ Getting Started

1. **Create a database** (PostgreSQL recommended, due to query syntax used)
   ```bash
   createdb fitzone_gym
   ```

2. **Create the schema**
   ```bash
   psql -d fitzone_gym -f DDL_FOR_GYM.sql
   ```

3. **Load seed data, in order**
   ```bash
   psql -d fitzone_gym -f DML_Phase1_Location.sql
   psql -d fitzone_gym -f DML_Phase2_Plan_Category_Equipment.sql
   psql -d fitzone_gym -f DML_Phase3_People.sql
   psql -d fitzone_gym -f DML_Phase4_Items_Buyers_Subscription_Attendance.sql
   psql -d fitzone_gym -f DML_Phase5_Invoice_InvoiceDetails_Refund.sql
   ```

4. **Run the analytical queries**
   ```bash
   psql -d fitzone_gym -f Complet_DQL_Script.sql
   ```
   Or open `Complet_DQL_Script.sql` and run individual queries in your SQL client / IDE of choice (pgAdmin, DBeaver, DataGrip, etc.).

## 📐 Design Documentation

- `FitZone_ER_Diagram.pdf` — Visual entity-relationship diagram showing all entities and their relationships.
- `FitZone_Relational_Schema.pdf` — The finalized relational schema derived from the ER model, with data types and keys.
- `FitZone_BCNF_Report_Cleaned.pdf` — Formal, table-by-table BCNF verification: functional dependencies, candidate keys, and the design decisions that eliminate partial, transitive, and BCNF-violating dependencies.

## 🎯 Project Purpose

This project was built as a DBMS coursework project (IT-214, Database Management Systems) to demonstrate:

- Conceptual modeling (ER diagrams) and schema normalization up to BCNF
- Translating a real-world domain (gym membership, retail, and trainer operations) into a relational schema
- Handling polymorphic relationships (a single `Buyer` abstraction over three distinct entity types) cleanly within a relational model
- Writing non-trivial SQL for reporting and operational queries, including relational division and set operations
- Referential integrity via primary/foreign key constraints and `CHECK` constraints across a multi-table schema

## 📄 License

No license has been specified for this repository. If you intend to reuse this project, please check with the repository owners.

## 🙋 Author

- Bhavin Thakor

