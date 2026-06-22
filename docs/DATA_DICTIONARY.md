# DATA DICTIONARY

## Smart Maintenance System

Version 1.0

---

# Naming Convention

Primary Key

id

Foreign Key

xxx_id

Boolean

is_xxx

Datetime

xxx_at

Timestamp

created_at

updated_at

Soft Delete

deleted_at

---

# 1. Users

| Field         | Type      | Required | Description   |
| ------------- | --------- | -------- | ------------- |
| id            | UUID      | ✅       | User ID       |
| employee_code | Text      | ✅       | Employee Code |
| full_name     | Text      | ✅       | Full Name     |
| role_id       | UUID      | ✅       | Role          |
| department_id | UUID      | ✅       | Department    |
| phone         | Text      | ❌       | Phone Number  |
| is_active     | Boolean   | ✅       | Active Status |
| created_at    | Timestamp | ✅       | Created Date  |
| updated_at    | Timestamp | ✅       | Updated Date  |

---

# 2. Roles

| Field       | Type |
| ----------- | ---- |
| id          | UUID |
| role_name   | Text |
| description | Text |

Examples

Admin

Leader

Technician

Operator

---

# 3. Departments

| Field           | Type      |
| --------------- | --------- |
| id              | UUID      |
| department_code | Text      |
| department_name | Text      |
| created_at      | Timestamp |

---

# 4. Production Lines

| Field         | Type      |
| ------------- | --------- |
| id            | UUID      |
| department_id | UUID      |
| line_code     | Text      |
| line_name     | Text      |
| created_at    | Timestamp |

---

# 5. Machine Types

| Field       | Type |
| ----------- | ---- |
| id          | UUID |
| type_code   | Text |
| type_name   | Text |
| description | Text |

Examples

SNJ

DNJ

OLJ

CUT

IRON

BOILER

---

# 6. Machines

| Field              | Type      | Required |
| ------------------ | --------- | -------- |
| id                 | UUID      | ✅       |
| machine_code       | Text      | ✅       |
| machine_name       | Text      | ✅       |
| machine_type_id    | UUID      | ✅       |
| department_id      | UUID      | ✅       |
| production_line_id | UUID      | ✅       |
| manufacturer       | Text      | ❌       |
| model              | Text      | ❌       |
| serial_number      | Text      | ❌       |
| install_date       | Date      | ❌       |
| status             | Enum      | ✅       |
| qr_code            | Text      | ✅       |
| created_at         | Timestamp | ✅       |
| updated_at         | Timestamp | ✅       |

Machine Status

Running

Breakdown

PM

Inactive

---

# 7. Work Orders

| Field         | Type      | Required |
| ------------- | --------- | -------- |
| id            | UUID      | ✅       |
| work_order_no | Text      | ✅       |
| machine_id    | UUID      | ✅       |
| reported_by   | UUID      | ✅       |
| assigned_to   | UUID      | ❌       |
| priority      | Enum      | ✅       |
| status        | Enum      | ✅       |
| description   | Text      | ✅       |
| accepted_at   | Timestamp | ❌       |
| started_at    | Timestamp | ❌       |
| finished_at   | Timestamp | ❌       |
| confirmed_at  | Timestamp | ❌       |
| confirmed_by  | UUID      | ❌       |
| created_at    | Timestamp | ✅       |

Priority

Critical

High

Medium

Low

Status

Open

Accepted

In Progress

Waiting Confirmation

Completed

Cancelled

---

# 8. Work Order Status History

| Field         | Type      |
| ------------- | --------- |
| id            | UUID      |
| work_order_id | UUID      |
| old_status    | Text      |
| new_status    | Text      |
| changed_by    | UUID      |
| changed_at    | Timestamp |

---

# 9. Failure Categories

| Field        | Type |
| ------------ | ---- |
| id           | UUID |
| failure_code | Text |
| failure_name | Text |
| description  | Text |

---

# 10. PM Plans

| Field          | Type    |
| -------------- | ------- |
| id             | UUID    |
| machine_id     | UUID    |
| plan_type      | Enum    |
| interval_value | Integer |
| is_active      | Boolean |

Plan Type

Daily

Weekly

Monthly

Running Hour

---

# 11. PM Schedules

| Field          | Type |
| -------------- | ---- |
| id             | UUID |
| pm_plan_id     | UUID |
| scheduled_date | Date |
| work_order_id  | UUID |
| status         | Enum |

---

# 12. Spare Parts

| Field         | Type    |
| ------------- | ------- |
| id            | UUID    |
| part_number   | Text    |
| part_name     | Text    |
| unit          | Text    |
| unit_cost     | Decimal |
| current_stock | Decimal |

---

# 13. Spare Usage

| Field         | Type    |
| ------------- | ------- |
| id            | UUID    |
| work_order_id | UUID    |
| spare_part_id | UUID    |
| quantity      | Decimal |
| remark        | Text    |

---

# Common Rules

- ทุกตารางใช้ UUID เป็น Primary Key
- ทุก Foreign Key ลงท้ายด้วย \_id
- ทุกวันที่ใช้ Timestamp
- created_at และ updated_at ใช้ทุกตาราง
- Soft Delete ใช้ deleted_at เมื่อจำเป็น
