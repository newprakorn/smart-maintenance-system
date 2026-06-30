# Machine Types

## Purpose

Machine Types ใช้กำหนดประเภทของเครื่องจักร เช่น จักรเข็มเดี่ยว จักรโพ้ง เครื่องตัด หรือหม้อน้ำ

Machine ทุกเครื่องต้องอ้างอิง Machine Type เพียงหนึ่งประเภท

---

## Business Usage

ใช้ใน

- Asset Management
- QR Code
- Work Order
- Preventive Maintenance
- Dashboard
- KPI

---

## Table

machine_types

---

## Fields

| Field       | Type         | Required | Description |
| ----------- | ------------ | -------- | ----------- |
| id          | UUID         | Yes      | Primary Key |
| code        | VARCHAR(20)  | Yes      | รหัสประเภท  |
| name        | VARCHAR(100) | Yes      | ชื่อประเภท  |
| description | TEXT         | No       | รายละเอียด  |
| is_active   | BOOLEAN      | Yes      | เปิดใช้งาน  |
| created_at  | TIMESTAMP    | Yes      | วันที่สร้าง |
| updated_at  | TIMESTAMP    | Yes      | วันที่แก้ไข |

---

## Constraints

- code ต้องไม่ซ้ำ
- name ต้องไม่ซ้ำ

---

## Business Rules

- ห้ามลบหากมี Machine ใช้งาน
- ใช้ is_active แทนการลบ
- Machine ต้องมี Machine Type เสมอ

---

## Relationships

Machine Types (1)

↓

Machines (Many)

---

## Permissions

| Role                | View | Create | Update | Delete |
| ------------------- | ---- | ------ | ------ | ------ |
| Admin               | ✅   | ✅     | ✅     | ❌     |
| Maintenance Manager | ✅   | ✅     | ✅     | ❌     |
| Technician          | ✅   | ❌     | ❌     | ❌     |

---

## Sample Data

| Code   | Name            |
| ------ | --------------- |
| SNJ    | Single Needle   |
| DNJ    | Double Needle   |
| OLJ    | Overlock        |
| CUT    | Cutting Machine |
| IRON   | Iron            |
| TABLE  | Iron Table      |
| BOILER | Boiler          |

---

## Future Expansion

- Default PM Template
- Default Spare Parts
- Expected MTBF
- Expected MTTR
