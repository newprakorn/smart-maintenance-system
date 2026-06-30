# Smart Maintenance System

# Business Rules

Version : 2.0

Status : Active

Last Updated : 2026-06-30

---

# Purpose

This document defines all business rules used by the Smart Maintenance System.

It is the official business reference for

- Developers
- Database Designers
- Frontend Developers
- AI Assistants
- Project Members

---

# Core Business Flow

Machine

↓

PM Plan

↓

PM Schedule

↓

PM Execution

↓

PM Compliance

↓

KPI

↓

Dashboard

---

# Machine Rules

One machine

can have

many PM Plans.

```
Machine

1

↓

N

PM Plan
```

Machine cannot be deleted if referenced by

- PM Plan

- Work Order

---

# PM Plan Rules

Each PM Plan belongs to only one Machine.

```
Machine

1

↓

N

PM Plan
```

One PM Plan

contains many Checklist Items.

```
PM Plan

1

↓

N

PM Plan Checklist
```

PM Plan can be

Active

Inactive

Inactive plans

cannot generate new schedules.

---

# Checklist Rules

Checklist Master

can be reused.

```
PM Checklist

↓

Reusable
```

Checklist is never linked directly to PM Execution.

Correct relationship

```
PM Execution

↓

PM Compliance

↓

PM Plan Checklist

↓

PM Checklist
```

This is mandatory.

---

# PM Schedule Rules

Each PM Plan

creates many schedules.

```
PM Plan

1

↓

N

PM Schedule
```

Schedule Status

Pending

In Progress

Completed

Cancelled

Overdue

---

# PM Execution Rules

One Schedule

can have one execution.

Execution Status

PASSED

FAILED

Execution cannot exist without Schedule.

---

# PM Compliance Rules

Compliance belongs to

Execution

and

PM Plan Checklist

Never reference

PM Checklist

directly.

Correct

```
PM Compliance

↓

PM Plan Checklist

↓

PM Checklist
```

---

# KPI Rules

Dashboard Summary

calculates

- Active Plans

- Today's PM

- Overdue PM

- Completed PM

- Failed PM

- Compliance Rate

KPI

is calculated

never manually entered.

---

# Work Order Rules

Machine

can have

many Work Orders.

```
Machine

1

↓

N

Work Order
```

Work Order Number

Column

```
work_order_no
```

Never

```
work_order_number
```

---

# Inventory Rules

(Reserved for Phase 9)

Machine

↓

Work Order

↓

Material Consumption

↓

Inventory Transaction

↓

Stock Balance

---

# Naming Rules

Use

Machine

Never

Asset

Use

work_order_no

Never

work_order_number

Use

checklist_item

Never

checklist_name

Use

pm_plan_checklist_id

Never

pm_checklist_id

inside

PM Compliance

---

# Development Rules

Business Rules

override

generated code.

If code conflicts with Business Rules

Business Rules

win.

---

# End of Document
