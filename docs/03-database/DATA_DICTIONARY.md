# Data Dictionary

## Purpose

This document defines the standard structure of every database table in the Smart Maintenance System (SMS).

Each entity will have:

- Table Name
- Description
- Primary Key
- Foreign Keys
- Columns
- Data Type
- Required
- Default Value
- Description

---

# Standard Audit Columns

Every business table must contain the following columns.

| Column     | Type      | Required | Description                 |
| ---------- | --------- | -------- | --------------------------- |
| id         | UUID      | Yes      | Primary Key                 |
| created_at | TIMESTAMP | Yes      | Record creation time        |
| updated_at | TIMESTAMP | Yes      | Last update time            |
| deleted_at | TIMESTAMP | No       | Soft delete timestamp       |
| created_by | UUID      | No       | User who created the record |
| updated_by | UUID      | No       | User who updated the record |

---

# Naming Standard

## Tables

Use

snake_case

Example

- machine
- machine_type
- work_order
- pm_plan

---

## Columns

Use

snake_case

Example

- machine_id
- machine_code
- machine_name
- created_at

---

## Primary Key

Every table

```text
id UUID PRIMARY KEY
```

---

## Foreign Key

Reference

```text
xxx_id
```

Example

- machine_type_id
- department_id
- company_id

---

## Data Types

| Type      | Usage                  |
| --------- | ---------------------- |
| UUID      | Primary / Foreign Keys |
| VARCHAR   | Short text             |
| TEXT      | Long description       |
| BOOLEAN   | True / False           |
| INTEGER   | Numbers                |
| NUMERIC   | Decimal                |
| DATE      | Date                   |
| TIMESTAMP | Date & Time            |

---

# Status

Detailed table definitions will be added in the next phase.
