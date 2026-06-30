# Entity Catalog

## Overview

This document contains all database entities used in the Smart Maintenance System (SMS).

Entities are grouped by business domain.

---

# 1. Organization Domain

| Entity     | Description         |
| ---------- | ------------------- |
| Company    | Company information |
| Plant      | Factory / Plant     |
| Department | Departments         |
| User       | System users        |
| Role       | User roles          |
| Permission | System permissions  |
| User Role  | User-role mapping   |

---

# 2. Asset Domain

| Entity                 | Description                    |
| ---------------------- | ------------------------------ |
| Machine                | Machine master                 |
| Machine Type           | Machine categories             |
| Machine Manufacturer   | Machine manufacturers          |
| Machine Model          | Machine models                 |
| Machine Location       | Machine installation locations |
| Machine Status         | Current machine status         |
| Machine Status History | Machine status history         |
| Machine Criticality    | Criticality levels             |
| Machine Document       | Manuals and documents          |
| Machine Image          | Machine images                 |

---

# 3. Maintenance Domain

| Entity           | Description              |
| ---------------- | ------------------------ |
| Work Request     | Repair request           |
| Work Order       | Maintenance work order   |
| Work Order Task  | Work order tasks         |
| Work Log         | Maintenance activity log |
| Downtime Record  | Machine downtime         |
| Failure Cause    | Failure cause master     |
| Failure Category | Failure categories       |

---

# 4. Preventive Maintenance Domain

| Entity       | Description                 |
| ------------ | --------------------------- |
| PM Plan      | Preventive maintenance plan |
| PM Schedule  | PM schedule                 |
| PM Checklist | PM checklist                |
| PM Result    | PM execution result         |
| PM History   | PM history                  |

---

# 5. Inventory Domain

| Entity                 | Description         |
| ---------------------- | ------------------- |
| Spare Part             | Spare part master   |
| Spare Part Category    | Spare part category |
| Spare Part Stock       | Stock quantity      |
| Spare Part Transaction | Stock movement      |
| Supplier               | Supplier master     |
| Purchase Request       | Purchase requests   |

---

# 6. Workflow Domain

| Entity           | Description          |
| ---------------- | -------------------- |
| Workflow         | Workflow definition  |
| Workflow Step    | Workflow steps       |
| Approval         | Approval records     |
| Approval History | Approval history     |
| Notification     | System notifications |

---

# 7. Configuration Domain

| Entity           | Description      |
| ---------------- | ---------------- |
| Holiday          | Company holidays |
| Shift            | Working shifts   |
| Overtime Rule    | OT rules         |
| Working Calendar | Working calendar |
| System Setting   | System settings  |

---

# Summary

| Domain                 | Entity Count |
| ---------------------- | -----------: |
| Organization           |            7 |
| Asset                  |           10 |
| Maintenance            |            7 |
| Preventive Maintenance |            5 |
| Inventory              |            6 |
| Workflow               |            5 |
| Configuration          |            5 |

**Total Estimated Entities: 45**
