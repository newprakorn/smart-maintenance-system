# Smart Maintenance System

# Project Rules

Version : 2.0

Status : Active

Last Updated : 2026-06-30

---

# Purpose

This document defines mandatory development rules for the Smart Maintenance System.

These rules apply to

- Database
- Backend
- Frontend
- API
- Documentation
- AI Assistants

---

# Rule 1

Migration First

Every database change

must be implemented

using a new migration.

Never modify old migrations.

---

# Rule 2

Database is Source of Truth

Database Schema

is the official reference.

Never guess

table names

column names

or relationships.

Always reference

01_DATABASE_SCHEMA.md

---

# Rule 3

Business Rules Override Code

If generated code conflicts with

Business Rules

Business Rules always win.

---

# Rule 4

Naming Convention

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

# Rule 5

Machine Naming

Use

machine

Never

asset

---

# Rule 6

Work Order Naming

Use

work_order_no

Never

work_order_number

---

# Rule 7

Checklist Naming

Use

checklist_item

Never

checklist_name

---

# Rule 8

PM Compliance

PM Compliance

must reference

pm_plan_checklist

Never

pm_checklist

directly.

Correct

PM Compliance

↓

PM Plan Checklist

↓

PM Checklist

---

# Rule 9

UUID

Every business table

must use

gen_random_uuid()

Primary Key.

---

# Rule 10

Audit Columns

Business tables

must contain

created_at

updated_at

created_by

updated_by

deleted_at

---

# Rule 11

Soft Delete

Never permanently delete

business data.

Use

deleted_at

---

# Rule 12

SQL Standard

Every migration

must contain

BEGIN;

...

COMMIT;

---

# Rule 13

Comments

Every new

Table

View

Function

Trigger

must contain

COMMENT.

---

# Rule 14

Git Workflow

Before coding

git pull

After development

git add .

git commit

git push

---

# Rule 15

Supabase Workflow

After every migration

run

supabase db reset

Migration

must pass

before commit.

---

# Rule 16

AI Workflow

AI must

never assume

Database Schema.

AI must use

Documentation

as Source of Truth.

---

# Rule 17

Documentation

When Database changes

Documentation

must be updated

in the same commit.

---

# Rule 18

Phase Workflow

Complete

Current Phase

↓

Documentation Update

↓

Git Commit

↓

Next Phase

---

# Rule 19

Production Rule

Never deploy

untested migration.

All migrations

must pass

supabase db reset.

---

# Rule 20

Project Principle

Documentation First

Database First

API First

Frontend Last

---

# End of Document
