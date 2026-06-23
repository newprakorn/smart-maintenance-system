---
# Entity 1 : Machine Types

## Purpose

Machine Types ใช้เก็บประเภทของเครื่องจักร เพื่อให้เครื่องจักรแต่ละเครื่องอ้างอิงประเภทเดียวกัน

การแยก Machine Type ออกจาก Machine ช่วยลดข้อมูลซ้ำ และสามารถเพิ่มประเภทเครื่องจักรใหม่ได้โดยไม่ต้องแก้ไขโครงสร้างฐานข้อมูล
---

## Examples

| Type Code | Type Name       |
| --------- | --------------- |
| SNJ       | Single Needle   |
| DNJ       | Double Needle   |
| OLJ       | Overlock        |
| CUT       | Cutting Machine |
| IRON      | Iron            |
| TABLE     | Iron Table      |
| BOILER    | Boiler          |
| COMP      | Air Compressor  |

---

## Table

machine_types

---

## Fields

| Field       | Type         | Description           |
| ----------- | ------------ | --------------------- |
| id          | UUID         | Primary Key           |
| type_code   | VARCHAR(20)  | รหัสประเภทเครื่องจักร |
| type_name   | VARCHAR(100) | ชื่อประเภทเครื่องจักร |
| description | TEXT         | รายละเอียด            |
| is_active   | BOOLEAN      | เปิด/ปิดการใช้งาน     |
| created_at  | TIMESTAMP    | วันที่สร้าง           |
| updated_at  | TIMESTAMP    | วันที่แก้ไขล่าสุด     |

---

## Primary Key

id

---

## Unique Key

type_code

---

## Business Rules

### BR-101

Machine Type Code ต้องไม่ซ้ำ

---

### BR-102

Machine Type สามารถถูกใช้งานโดยหลาย Machine

Relationship

Machine Type (1)

↓

Machines (Many)

---

### BR-103

ห้ามลบ Machine Type หากยังมี Machine ใช้งานอยู่

ให้เปลี่ยน

is_active = false

แทน

---

### BR-104

Machine Type สามารถเพิ่มได้โดย Maintenance Manager หรือ Administrator เท่านั้น

---

## Notes

Machine Type ใช้สำหรับจัดหมวดหมู่เครื่องจักรเท่านั้น

ไม่เก็บข้อมูลตำแหน่ง

ไม่เก็บข้อมูลสถานะ

ไม่เก็บข้อมูลประวัติการซ่อม

# Entity 2 : Machines

## Purpose

Machines เป็นตารางหลักของระบบ

เก็บข้อมูลเครื่องจักรทุกเครื่องภายในโรงงาน

Machine ทุกเครื่องจะมี Machine Code เพียงหนึ่งเดียว และมี QR Code เพียงหนึ่งเดียว

Machine จะเชื่อมโยงกับ

- Work Orders
- Preventive Maintenance
- Machine Status
- Machine Location
- Machine History
- Downtime
- Dashboard

---

## Examples

| Machine Code   | Machine Name       |
| -------------- | ------------------ |
| MC-SNJ-MAC-111 | Single Needle #111 |
| MC-DNJ-MAC-015 | Double Needle #015 |
| MC-OLJ-MAC-008 | Overlock #008      |

---

## Table

machines

---

## Fields

| Field               | Type         | Description                   |
| ------------------- | ------------ | ----------------------------- |
| id                  | UUID         | Primary Key                   |
| machine_code        | VARCHAR(50)  | รหัสเครื่องจักร               |
| machine_name        | VARCHAR(150) | ชื่อเครื่องจักร               |
| machine_type_id     | UUID         | FK → Machine Types            |
| manufacturer_id     | UUID         | FK → Machine Manufacturers    |
| model_id            | UUID         | FK → Machine Models           |
| criticality_id      | UUID         | FK → Machine Criticalities    |
| serial_number       | VARCHAR(100) | Serial Number                 |
| purchase_date       | DATE         | วันที่ซื้อ                    |
| install_date        | DATE         | วันที่ติดตั้ง                 |
| qr_code             | VARCHAR(100) | QR Code                       |
| current_location_id | UUID         | FK → Machine Location History |
| is_active           | BOOLEAN      | เปิดใช้งาน                    |
| remark              | TEXT         | หมายเหตุ                      |
| created_at          | TIMESTAMP    | วันที่สร้าง                   |
| updated_at          | TIMESTAMP    | วันที่แก้ไขล่าสุด             |

---

## Primary Key

id

---

## Unique Keys

- Machine Code
- QR Code
- Serial Number (ถ้ามี)

---

## Business Rules

### BR-201

Machine Code ต้องไม่ซ้ำ

---

### BR-202

QR Code ต้องไม่ซ้ำ

---

### BR-203

Machine หนึ่งเครื่องมี Machine Type ได้เพียงประเภทเดียว

---

### BR-204

Machine หนึ่งเครื่องมี Manufacturer ได้เพียงหนึ่งราย

---

### BR-205

Machine หนึ่งเครื่องมี Model ได้เพียงหนึ่งรุ่น

---

### BR-206

Machine หนึ่งเครื่องมี Criticality ได้เพียงหนึ่งระดับ

---

### BR-207

Machine หนึ่งเครื่องมี Current Location ได้เพียงตำแหน่งเดียว

แต่สามารถย้ายตำแหน่งได้ไม่จำกัดจำนวนครั้ง

ประวัติการย้ายจะถูกเก็บใน Machine Location History

---

### BR-208

Machine หนึ่งเครื่องสามารถมี Work Order ได้หลายรายการ

---

### BR-209

Machine หนึ่งเครื่องสามารถมี PM Schedule ได้หลายรายการ

---

### BR-210

Machine ที่ถูกยกเลิกการใช้งาน

ห้ามลบ

ให้เปลี่ยน

is_active = false

---

### BR-211

Machine Code จะไม่เปลี่ยนตลอดอายุการใช้งานของเครื่องจักร

แม้จะย้าย Line

ย้าย Department

หรือย้าย Factory

---

## Relationships

Machine Types

1

↓

Many

Machines

Machine Manufacturers

1

↓

Many

Machine Models

Machine Models

1

↓

Many

Machines

Machine Criticalities

1

↓

Many

Machines

Machines

1

↓

Many

Work Orders

Machines

1

↓

Many

PM Schedules

Machines

1

↓

Many

Machine Location History

Machines

1

↓

Many

Machine Status History

---

## Notes

Machine เป็น Master Data ที่สำคัญที่สุดของระบบ

ทุก Module จะอ้างอิง Machine ผ่าน Machine ID

## Machine จะอ้างอิงข้อมูลมาตรฐานทั้งหมดผ่าน Foreign Key เพื่อป้องกันข้อมูลซ้ำและรองรับการขยายระบบในอนาคต

# Entity 3 : Machine Locations

## Purpose

Machine Locations ใช้เก็บตำแหน่งปัจจุบันและประวัติการย้ายของเครื่องจักร

Machine สามารถย้ายระหว่าง

- Factory
- Department
- Production Line

โดยไม่สูญเสียประวัติ

---

## Table

machine_location_history

---

## Fields

| Field              | Type      | Description                 |
| ------------------ | --------- | --------------------------- |
| id                 | UUID      | Primary Key                 |
| machine_id         | UUID      | FK -> Machines              |
| factory_id         | UUID      | FK -> Factories             |
| department_id      | UUID      | FK -> Departments           |
| production_line_id | UUID      | FK -> Production Lines      |
| effective_from     | TIMESTAMP | วันที่เริ่มใช้งานตำแหน่งนี้ |
| effective_to       | TIMESTAMP | วันที่สิ้นสุดตำแหน่ง        |
| is_current         | BOOLEAN   | ตำแหน่งปัจจุบัน             |
| remark             | TEXT      | หมายเหตุ                    |
| created_at         | TIMESTAMP | วันที่สร้าง                 |

---

## Primary Key

id

---

## Business Rules

### BR-301

Machine หนึ่งเครื่องมี Current Location ได้เพียงหนึ่งเดียว

---

### BR-302

เมื่อย้ายเครื่อง

Record เดิม

is_current = false

และกำหนด

effective_to

---

### BR-303

สร้าง Record ใหม่

is_current = true

พร้อมกำหนด

effective_from

---

### BR-304

Machine สามารถย้าย

- Line
- Department
- Factory

ได้ไม่จำกัดจำนวนครั้ง

---

### BR-305

ห้ามแก้ไขประวัติการย้ายย้อนหลัง

หากข้อมูลผิด ให้สร้าง Correction Record ตามขั้นตอนที่กำหนด

---

## Relationships

Machines

1

↓

Many

Machine Location History

Factories

1

↓

Many

Machine Location History

Departments

1

↓

Many

Machine Location History

Production Lines

1

↓

Many

Machine Location History

---

## Example

Machine

MC-SNJ-MAC-111

History

Factory A

↓

Sewing Department

↓

Line N1

2025-01-01

↓

Factory A

↓

Sewing Department

↓

Line N2

2026-02-10

↓

Factory A

↓

Finishing Department

↓

Line F3

2027-04-01

---

## Notes

Machine จะอ้างอิงตำแหน่งปัจจุบันผ่าน

current_location_id

แต่ประวัติทั้งหมดจะเก็บไว้ใน

## machine_location_history

# Entity 4 : Machine Status History

## Purpose

Machine Status History ใช้เก็บประวัติการเปลี่ยนสถานะของเครื่องจักร

ระบบจะไม่เก็บเฉพาะสถานะปัจจุบัน แต่เก็บทุกการเปลี่ยนแปลง เพื่อใช้วิเคราะห์ประสิทธิภาพเครื่องจักรในอนาคต

---

## Standard Machine Status

| Status                 | Description        |
| ---------------------- | ------------------ |
| Running                | เครื่องทำงานปกติ   |
| Breakdown              | เครื่องเสีย        |
| Waiting Parts          | รออะไหล่           |
| Preventive Maintenance | อยู่ระหว่าง PM     |
| Idle                   | หยุดใช้งานชั่วคราว |
| Retired                | ยกเลิกการใช้งาน    |

---

## Table

machine_status_history

---

## Fields

| Field         | Type        | Description                  |
| ------------- | ----------- | ---------------------------- |
| id            | UUID        | Primary Key                  |
| machine_id    | UUID        | FK -> Machines               |
| status        | VARCHAR(50) | สถานะเครื่องจักร             |
| work_order_id | UUID        | FK -> Work Orders (Nullable) |
| changed_by    | UUID        | ผู้เปลี่ยนสถานะ              |
| changed_at    | TIMESTAMP   | วันที่เปลี่ยนสถานะ           |
| remark        | TEXT        | หมายเหตุ                     |

---

## Primary Key

id

---

## Business Rules

### BR-401

Machine มีสถานะปัจจุบันได้เพียงหนึ่งสถานะ

---

### BR-402

ทุกครั้งที่สถานะเปลี่ยน

ต้องสร้าง History Record ใหม่

ห้ามแก้ไข Record เดิม

---

### BR-403

Waiting Parts ใช้เมื่อ

- ช่างตรวจสอบแล้ว
- ต้องรออะไหล่
- งานยังไม่สามารถปิดได้

---

### BR-404

Preventive Maintenance ใช้เมื่อ

Machine อยู่ระหว่างการทำ PM

---

### BR-405

Breakdown จะเกิดจากการเปิด Work Order ประเภท Breakdown

---

### BR-406

เมื่อ Work Order ปิด

Machine ต้องกลับเป็น

Running

หากไม่มีเหตุขัดข้องอื่น

---

## Relationships

Machines

1

↓

Many

Machine Status History

Work Orders

1

↓

Many

Machine Status History

---

## Example

Running

↓

Breakdown

↓

Waiting Parts

↓

Breakdown

↓

Running

---

## Future KPI

ข้อมูลจากตารางนี้สามารถใช้คำนวณ

- Downtime
- MTTR
- MTBF
- Availability
- OEE
- Waiting Parts Time
- PM Time
- Breakdown Frequency

---

## Notes

Machine Status History เป็นข้อมูลเชิงเวลา (Time Series)

ห้ามลบข้อมูลย้อนหลัง

เพื่อรักษาความถูกต้องของ KPI และรายงาน
