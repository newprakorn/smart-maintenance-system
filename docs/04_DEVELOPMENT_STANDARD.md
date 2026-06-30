# Smart Maintenance System

# Development Standard

Version : 2.0

Status : Active

Last Updated : 2026-06-30

---

# Purpose

This document defines the coding and development standards for the Smart Maintenance System.

All developers and AI assistants must follow these standards.

---

# Development Philosophy

Documentation First

↓

Database First

↓

Backend

↓

Frontend

↓

Deployment

---

# Folder Structure

Project

```
src/

components/

pages/

hooks/

services/

types/

utils/

supabase/

docs/
```

---

# SQL Standard

Every migration must contain

```
BEGIN;

...

COMMIT;
```

Never edit previous migration files.

Always create a new migration.

---

# PostgreSQL Standard

Primary Key

UUID

```
gen_random_uuid()
```

Foreign Keys

Explicitly define all FK constraints.

Indexes

Create indexes for

- Foreign Keys
- Frequently searched columns

Comments

Use

COMMENT ON TABLE

COMMENT ON COLUMN

COMMENT ON FUNCTION

---

# Supabase Standard

Database changes

↓

Migration

↓

supabase db reset

↓

Verify

↓

Commit

Never commit untested migrations.

---

# TypeScript Standard

Strict Mode

Enabled

No

any

unless absolutely necessary.

Prefer

interface

for data models.

---

# React Standard

Functional Components

Only

Use Hooks

No Class Components

Component Naming

PascalCase

Example

MachineCard.tsx

PMDashboard.tsx

---

# File Naming

React

PascalCase

Database

snake_case

Markdown

UPPER_CASE or Numbered

Examples

01_DATABASE_SCHEMA.md

02_BUSINESS_RULES.md

---

# Git Standard

Before coding

git pull

After coding

git add .

git commit

git push

---

# Commit Message Standard

Feature

```
feat(module): description
```

Fix

```
fix(module): description
```

Documentation

```
docs: description
```

Refactor

```
refactor(module): description
```

---

# Documentation Standard

Every new module

must update

Documentation.

Documentation is part of development.

---

# Testing Standard

Every migration

must pass

```
supabase db reset
```

before commit.

Every React page

must compile without TypeScript errors.

---

# AI Development Standard

AI must

never assume

Database Schema.

AI must reference

01_DATABASE_SCHEMA.md

02_BUSINESS_RULES.md

03_PROJECT_RULES.md

before generating SQL or code.

If uncertainty exists,

AI must ask or verify,

not guess.

---

# Project Workflow

Documentation

↓

Migration

↓

Database

↓

Backend

↓

Frontend

↓

Testing

↓

Git

↓

Deployment

---

# Quality Checklist

Before every commit

- Database verified
- Migration verified
- Documentation updated
- TypeScript passed
- SQL reviewed
- Naming checked

---

# End of Document
