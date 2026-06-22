# Coding Standard

## Purpose

This document defines the coding standards for the Smart Maintenance System.

All contributors and AI assistants must follow these standards to maintain consistency, readability, and maintainability.

---

# General Principles

- Write clean and readable code.
- Prefer simplicity over cleverness.
- Avoid duplicated logic.
- Follow the Single Responsibility Principle.
- Keep components small and reusable.

---

# Technology Stack

Frontend

- React 19
- TypeScript
- Vite
- Tailwind CSS

Backend

- Supabase

Package Manager

- pnpm

---

# Naming Convention

## Files

React Components

PascalCase

Examples

```text
MachineCard.tsx
DashboardPage.tsx
```

Hooks

camelCase with "use"

```text
useAuth.ts
useMachine.ts
```

Utilities

camelCase

```text
formatDate.ts
calculatePM.ts
```

Types

```text
machine.ts
workOrder.ts
```

---

# Variables

Use camelCase

```ts
machineName
workOrderId
currentUser
```

Constants

UPPER_SNAKE_CASE

```ts
MAX_RETRY
DEFAULT_PAGE_SIZE
```

Interfaces

PascalCase

```ts
interface Machine
interface WorkOrder
```

Enums

PascalCase

```ts
enum WorkOrderStatus
```

---

# Folder Structure

Use Feature-based Architecture.

```text
src/

app/

components/

features/

hooks/

layouts/

services/

types/

utils/
```

Business logic belongs inside

```text
features/
```

Shared UI belongs inside

```text
components/
```

---

# React Rules

Use Functional Components only.

Use Hooks.

Avoid Class Components.

Prefer composition over inheritance.

---

# TypeScript Rules

Always use strict typing.

Avoid

```ts
any
```

Prefer

```ts
unknown
```

or proper interfaces.

Use interfaces for object models.

Use type aliases for utility types.

---

# Import Order

1. React
2. Third-party libraries
3. Internal modules
4. Relative imports
5. Styles

Example

```ts
import { useState } from 'react'

import { Link } from 'react-router-dom'

import { Button } from '@/components/ui/button'

import './style.css'
```

---

# Components

One component per file.

Keep components focused.

Extract reusable logic into Hooks.

Avoid components larger than 300 lines.

---

# State Management

Local state

React Hooks

Global state

Will be introduced only when necessary.

Avoid unnecessary global state.

---

# API Access

Never call Supabase directly inside UI components.

Always use

```text
services/
```

or

```text
features/
```

to access backend services.

---

# Error Handling

Never ignore errors.

Use

try / catch

for asynchronous operations.

Display user-friendly error messages.

Log unexpected errors.

---

# Comments

Write self-explanatory code.

Only comment complex business logic.

Avoid redundant comments.

Bad

```ts
// increment i
i++
```

Good

```ts
// Running-hour calculation follows maintenance policy.
```

---

# Formatting

Use ESLint.

Use Prettier.

Never manually format code against project rules.

---

# Git Commit

Use Conventional Commits.

Examples

```text
feat: add machine dashboard

fix: correct PM schedule

docs: update architecture

refactor: simplify QR scanner
```

---

# Pull Request Checklist

Before pushing code

- ESLint passes
- TypeScript passes
- Build succeeds
- No unused imports
- No console.log left in production code

---

# References

- AI_RULES.md
- DEVELOPMENT.md
- ARCHITECTURE.md
