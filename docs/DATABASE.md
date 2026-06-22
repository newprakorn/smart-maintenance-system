# Database Design

## Purpose

This document defines the database architecture for the Smart Maintenance System.

It serves as the single source of truth for database design, table structures, relationships, and future migrations.

---

# Database Platform

Database

- Supabase PostgreSQL

Authentication

- Supabase Auth

Storage

- Not Used (Current Version)

Realtime

- Reserved for Future Development

---

# Design Principles

The database must satisfy the following goals:

- Normalize data where appropriate.
- Avoid duplicated information.
- Support future scalability.
- Maintain referential integrity.
- Be easy to extend.

---

# Current Status

Project Status

- Database Design Phase

Tables

- Not Implemented

Relationships

- Not Implemented

Row Level Security

- Not Implemented

---

# Planned Modules

The following business modules will be implemented.

## User Management

- Users
- Roles
- Authentication

---

## Machine Management

- Machines
- Machine Categories
- Locations
- Departments

---

## Preventive Maintenance

- PM Plans
- PM Schedules
- PM History

---

## Work Orders

- Work Orders
- Work Order Status
- Assigned Technician

---

## Inspection

- Inspection Checklist
- Inspection Result

---

## Maintenance History

- Repair History
- Breakdown History

---

## Dashboard

- KPI
- Machine Status
- PM Summary

---

# Planned Tables

The following tables are expected.

```text
profiles
roles

machines
machine_categories
locations
departments

pm_plans
pm_schedule

work_orders

maintenance_history

checklists
checklist_items

notifications
```

---

# Naming Convention

Tables

- snake_case
- plural names

Examples

- machines
- work_orders
- pm_plans

Columns

- snake_case

Primary Key

- id (UUID)

Foreign Key

- \*\_id

Examples

- machine_id
- user_id
- department_id

---

# Data Types

Primary Key

UUID

Date

DATE

Date Time

TIMESTAMP WITH TIME ZONE

Boolean

BOOLEAN

Text

TEXT

Number

INTEGER

Decimal

NUMERIC

---

# Relationships

Relationships will be documented after ER Diagram design.

---

# Migration Strategy

Every database change must be versioned.

Migration files will be managed by Supabase CLI.

---

# Row Level Security (Future)

The application will use Row Level Security (RLS).

Policies will be documented after authentication design.

---

# References

- BUSINESS_RULES.md
- ARCHITECTURE.md
- ROADMAP.md
