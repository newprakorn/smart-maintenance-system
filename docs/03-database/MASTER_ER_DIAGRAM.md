# Master ER Diagram

## Purpose

This document describes the high-level relationship between all business domains in the Smart Maintenance System (SMS).

Detailed ER diagrams are maintained separately for each domain.

---

# System Overview

```text
Company
│
├── Plant
│   │
│   ├── Department
│   │   │
│   │   ├── User
│   │   └── Machine
│   │
│   └── Warehouse
│
├── Machine
│   │
│   ├── Machine Type
│   ├── Manufacturer
│   ├── Location
│   ├── Status
│   └── Criticality
│
├── Work Request
│   │
│   └── Work Order
│       │
│       ├── Work Log
│       ├── Downtime
│       ├── Spare Part Usage
│       └── Approval
│
├── PM Plan
│   │
│   ├── PM Schedule
│   ├── PM Checklist
│   └── PM History
│
├── Spare Part
│   │
│   ├── Stock
│   ├── Transaction
│   └── Supplier
│
└── Workflow
    ├── Workflow Step
    ├── Approval
    └── Notification
```

---

# Domain Relationships

## Organization

Company

↓

Plant

↓

Department

↓

User

---

## Asset

Machine

↓

Machine Type

↓

Manufacturer

↓

Location

↓

Status

---

## Maintenance

Work Request

↓

Work Order

↓

Work Log

↓

Downtime

---

## Preventive Maintenance

PM Plan

↓

PM Schedule

↓

PM Checklist

↓

PM History

---

## Inventory

Spare Part

↓

Stock

↓

Transaction

↓

Supplier

---

## Workflow

Workflow

↓

Workflow Step

↓

Approval

↓

Notification

---

# Status

High-level database blueprint completed.

Detailed ER diagrams are documented separately in:

- ER_ORGANIZATION_DOMAIN.md
- ER_ASSET_DOMAIN.md
- ER_MAINTENANCE_DOMAIN.md
- ER_PM_DOMAIN.md
- ER_INVENTORY_DOMAIN.md
- ER_WORKFLOW_DOMAIN.md
- ER_CONFIGURATION_DOMAIN.md
