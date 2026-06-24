# Database Architecture

## Overview

The Smart Maintenance System (SMS) uses PostgreSQL hosted on Supabase.

The database is designed using Domain-Driven Design (DDD).

---

# Database Structure

```text
public
│
├── Organization
│
├── Asset
│
├── Maintenance
│
├── Preventive Maintenance
│
├── Inventory
│
├── Workflow
│
├── Configuration
│
├── Views
│
├── Functions
│
└── Policies (RLS)
```

---

# Database Standards

## Primary Keys

Every table uses

- UUID

---

## Audit Columns

Every business table contains

- created_at
- updated_at
- deleted_at
- created_by
- updated_by

---

## Soft Delete

Business data must never be permanently deleted.

Records are marked by

deleted_at

---

## Naming Convention

Tables

snake_case

Example

- machine
- work_order
- pm_plan

Columns

snake_case

Example

- machine_code
- machine_name
- created_at

---

# Database Domains

Organization

- Company
- Plant
- Department
- User

Asset

- Machine
- Machine Type
- Manufacturer
- Location

Maintenance

- Work Request
- Work Order
- Work Log

Preventive Maintenance

- PM Plan
- PM Schedule
- PM History

Inventory

- Spare Part
- Stock
- Supplier

Workflow

- Workflow
- Approval
- Notification

Configuration

- Holiday
- Shift
- System Setting

---

# Migration Strategy

```
001_initial_schema.sql

↓

002_master_data.sql

↓

003_seed.sql

↓

004_views.sql

↓

005_functions.sql

↓

006_policies.sql
```

---

# Development Workflow

ER Diagram

↓

Entity Catalog

↓

Data Dictionary

↓

SQL Migration

↓

Supabase

↓

React

↓

Production
