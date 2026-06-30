# Smart Maintenance System

# Database Schema

Version : 2.0

Status : Active

Last Updated : 2026-06-30

---

# Database Philosophy

The database follows

- PostgreSQL
- Supabase
- UUID Primary Keys
- Soft Delete
- Audit Trail
- Domain Driven Design

---

# Schema

public

---

# Core Domains

Organization

Machine

Maintenance

Preventive Maintenance

Inventory

Workflow

Reporting

---

# Naming Convention

Tables

snake_case

Examples

machine

work_order

pm_plan

Columns

snake_case

Examples

machine_code

machine_name

created_at

updated_at

---

# UUID Standard

All business tables use

gen_random_uuid()

---

# Audit Columns

Every business table contains

created_at

updated_at

created_by

updated_by

deleted_at

---

# Machine Domain

machine

Primary Key

id

Columns

id

machine_code

machine_name

asset_type_id

manufacturer_id

model_id

location_id

serial_number

...

Referenced By

pm_plan

work_order

machine_component

---

# Preventive Maintenance Domain

pm_plan

↓

pm_schedule

↓

pm_execution

↓

pm_compliance

↓

pm_plan_checklist

↓

pm_checklist

---

## pm_plan

Purpose

Defines preventive maintenance plans.

Primary Key

id

Foreign Keys

machine_id

Main Columns

plan_code

plan_name

maintenance_type

description

is_active

Relationships

machine

1

↓

N

pm_plan

---

## pm_schedule

Purpose

Stores generated PM schedules.

Foreign Keys

pm_plan_id

---

## pm_execution

Purpose

Stores actual PM execution.

Foreign Keys

pm_schedule_id

---

## pm_plan_checklist

Purpose

Maps Checklist to PM Plan.

Foreign Keys

pm_plan_id

pm_checklist_id

---

## pm_checklist

Purpose

Master checklist.

Main Column

checklist_item

---

## pm_compliance

Purpose

Stores compliance result.

Foreign Keys

pm_execution_id

pm_plan_checklist_id

Important Rule

Never reference

pm_checklist

directly.

Always

pm_compliance

↓

pm_plan_checklist

↓

pm_checklist

---

# Work Order

work_order

Primary Key

id

Main Column

work_order_no

Machine FK

machine_id

---

# Important Project Rules

Machine table is

machine

NOT

asset

---

Work Order Number

work_order_no

NOT

work_order_number

---

Checklist Name

checklist_item

NOT

checklist_name

---

Compliance

uses

pm_plan_checklist_id

NOT

pm_checklist_id

---

# End of Document
