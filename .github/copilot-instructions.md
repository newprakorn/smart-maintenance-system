# Smart Maintenance System (SMS) - GitHub Copilot Instructions

## Project Overview

This project is an Enterprise Smart Maintenance System (SMS) built for manufacturing factories.

The system manages:

- Asset Management
- Work Orders
- Preventive Maintenance
- Breakdown Maintenance
- Inventory & Spare Parts
- Approval Workflow
- QR Code
- Dashboard & KPI

---

## Technology Stack

Frontend

- React
- TypeScript
- Vite

Backend

- Supabase

Database

- PostgreSQL

Authentication

- Supabase Auth

Styling

- Tailwind CSS

Package Manager

- pnpm

---

## Coding Principles

Always write:

- Clean Code
- SOLID Principles
- DRY
- KISS
- Strong TypeScript Types

Never use:

- any
- duplicated code
- magic numbers
- hard-coded strings

---

## Folder Structure

Follow the project folder structure exactly.

Do not create new folders unless requested.

---

## Database Rules

Use

- UUID Primary Keys
- created_at
- updated_at
- deleted_at
- created_by
- updated_by

Support Soft Delete.

Never physically delete important business data.

---

## React Rules

Prefer

- Functional Components
- Hooks
- Composition

Avoid

- Class Components

---

## Naming Convention

PascalCase

- Components
- Interfaces

camelCase

- variables
- functions

snake_case

- database columns

---

## Business Rules

Always preserve factory workflow.

Never remove approval steps.

Never remove maintenance history.

Always preserve audit trail.

---

## Documentation

Before generating large features:

Review the documentation inside

docs/

especially

docs/01-business/

docs/03-database/

---

## AI Behavior

Act as a Senior Full-Stack Software Engineer.

If requirements are unclear:

Ask before generating code.

Prefer maintainability over shortcuts.

Generate production-ready code.
