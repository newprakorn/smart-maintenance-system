# ASSET_MASTER_DATA

## Phase

5.3B – Asset Master Data Design

---

# Purpose

Asset Master Data คือข้อมูลมาตรฐานที่ระบบ Smart Maintenance System ใช้อ้างอิงร่วมกัน

ทุกข้อมูลในกลุ่มนี้สามารถจัดการผ่านหน้าจอ Administrator หรือ Maintenance Manager

การแยก Master Data ออกจากข้อมูลธุรกรรม (Transaction) ทำให้

- ลดข้อมูลซ้ำ
- เพิ่มความยืดหยุ่น
- รองรับการขยายระบบในอนาคต
- ไม่ต้องแก้ไขโครงสร้างฐานข้อมูลเมื่อเพิ่มข้อมูลใหม่

---

# Scope

Asset Master Data ครอบคลุม

- Machine Types
- Machine Statuses
- Machine Categories
- Machine Manufacturers
- Machine Models
- Machine Criticalities

---

# Objectives

รองรับ

- Machine Management
- QR Code
- Work Orders
- PM
- Dashboard
- KPI
- MTTR
- MTBF
- Future AI
- Future IoT

---

# Master Data Principles

Master Data

↓

Transaction

↓

History

↓

Reports

↓

Dashboard

ข้อมูล Master จะถูกอ้างอิงด้วย Foreign Key

ระบบจะไม่เก็บข้อความซ้ำใน Transaction Tables

---

# Naming Convention

Primary Key

id

Code

code

Name

name

Description

description

Active Flag

is_active

Created Date

created_at

Updated Date

updated_at

---

# Standard Fields

Master Tables ทุกตารางจะมี Field ดังต่อไปนี้

| Field       | Type      |
| ----------- | --------- |
| id          | UUID      |
| code        | VARCHAR   |
| name        | VARCHAR   |
| description | TEXT      |
| is_active   | BOOLEAN   |
| created_at  | TIMESTAMP |
| updated_at  | TIMESTAMP |

---

# Status

Draft

## Version 1.0

# Master Table 1 : Machine Statuses

## Purpose

Machine Statuses เป็น Master Data สำหรับกำหนดสถานะของเครื่องจักร

ระบบจะอ้างอิงสถานะผ่าน Foreign Key แทนการเก็บข้อความโดยตรง

Administrator และ Maintenance Manager สามารถเพิ่ม แก้ไข หรือปิดการใช้งานสถานะได้

---

## Table

machine_statuses

---

## Standard Status

| Code | Name (EN)              | Name (TH)          |
| ---- | ---------------------- | ------------------ |
| RUN  | Running                | กำลังทำงาน         |
| BD   | Breakdown              | เครื่องเสีย        |
| WP   | Waiting Parts          | รออะไหล่           |
| PM   | Preventive Maintenance | กำลังทำ PM         |
| IDLE | Idle                   | หยุดใช้งานชั่วคราว |
| RET  | Retired                | ยกเลิกการใช้งาน    |

---

## Fields

| Field       | Type         | Description        |
| ----------- | ------------ | ------------------ |
| id          | UUID         | Primary Key        |
| code        | VARCHAR(20)  | รหัสสถานะ          |
| name_en     | VARCHAR(100) | ชื่อภาษาอังกฤษ     |
| name_th     | VARCHAR(100) | ชื่อภาษาไทย        |
| color       | VARCHAR(20)  | สีสำหรับ Dashboard |
| icon        | VARCHAR(50)  | Icon               |
| sort_order  | INTEGER      | ลำดับการแสดงผล     |
| is_active   | BOOLEAN      | เปิดใช้งาน         |
| description | TEXT         | รายละเอียด         |
| created_at  | TIMESTAMP    | วันที่สร้าง        |
| updated_at  | TIMESTAMP    | วันที่แก้ไขล่าสุด  |

---

## Primary Key

id

---

## Unique Key

code

---

## Business Rules

### BR-MS-001

Status Code ต้องไม่ซ้ำ

---

### BR-MS-002

ห้ามลบ Status ที่ถูกใช้งานแล้ว

ให้เปลี่ยน

is_active = false

---

### BR-MS-003

Status สามารถเพิ่มได้โดย

- Administrator
- Maintenance Manager

---

### BR-MS-004

Dashboard ใช้ color และ icon จาก Master Table นี้

---

### BR-MS-005

Transaction ทุกตารางต้องอ้างอิง Status ผ่าน status_id

ห้ามเก็บข้อความ Running, Breakdown, Waiting Parts โดยตรง

---

## Example

| Code | Color  |
| ---- | ------ |
| RUN  | Green  |
| BD   | Red    |
| WP   | Orange |
| PM   | Blue   |
| IDLE | Gray   |
| RET  | Black  |

---

## Future Expansion

สามารถเพิ่มสถานะใหม่ได้ เช่น

- Calibration
- Cleaning
- Inspection
- Trial Run
- Shutdown
- Production Hold

## โดยไม่ต้องแก้ไขโครงสร้างฐานข้อมูล

# Master Table 2 : Machine Criticalities

## Purpose

Machine Criticalities ใช้กำหนดระดับความสำคัญของเครื่องจักร

ระดับความสำคัญนี้ใช้ในการ

- วางแผน PM
- จัดลำดับการซ่อม
- Dashboard
- KPI
- Risk Assessment

---

## Table

machine_criticalities

---

## Standard Levels

| Code | Name     | Description                       |
| ---- | -------- | --------------------------------- |
| C    | Critical | เครื่องหยุดแล้วกระทบการผลิตทันที  |
| H    | High     | กระทบการผลิต แต่ยังมีเครื่องสำรอง |
| M    | Medium   | กระทบปานกลาง                      |
| L    | Low      | กระทบน้อย                         |

---

## Fields

| Field          | Type        | Description       |
| -------------- | ----------- | ----------------- |
| id             | UUID        | Primary Key       |
| code           | VARCHAR(10) | รหัสระดับ         |
| name           | VARCHAR(50) | ชื่อระดับ         |
| priority_order | INTEGER     | ลำดับความสำคัญ    |
| color          | VARCHAR(20) | สีบน Dashboard    |
| description    | TEXT        | รายละเอียด        |
| is_active      | BOOLEAN     | เปิดใช้งาน        |
| created_at     | TIMESTAMP   | วันที่สร้าง       |
| updated_at     | TIMESTAMP   | วันที่แก้ไขล่าสุด |

---

## Business Rules

### BR-MC-001

Machine ทุกเครื่องต้องมี Criticality

---

### BR-MC-002

Criticality สามารถเปลี่ยนได้โดย

- Administrator
- Maintenance Manager

---

### BR-MC-003

Dashboard ใช้สีจาก Master Table นี้

---

### BR-MC-004

PM สามารถกำหนดความถี่ตาม Criticality ได้

ตัวอย่าง

Critical

→ ทุก 1 เดือน

High

→ ทุก 3 เดือน

Medium

→ ทุก 6 เดือน

Low

→ ทุก 12 เดือน

---

## Example

| Code | Color  |
| ---- | ------ |
| C    | Red    |
| H    | Orange |
| M    | Yellow |
| L    | Green  |

---

## Notes

Machine จะอ้างอิง Criticality ผ่าน

criticality_id

เพื่อให้สามารถเปลี่ยนระดับความสำคัญได้โดยไม่กระทบข้อมูลประวัติ

# Master Table 3 : Machine Manufacturers

## Purpose

Machine Manufacturers ใช้เก็บรายชื่อผู้ผลิตเครื่องจักร

การแยกผู้ผลิตออกเป็น Master Data ช่วยลดข้อมูลซ้ำ และสามารถใช้ในการวิเคราะห์ความน่าเชื่อถือของผู้ผลิตในอนาคต

---

## Table

machine_manufacturers

---

## Example Data

| Code    | Manufacturer |
| ------- | ------------ |
| JUKI    | JUKI         |
| BROTHER | Brother      |
| PEGASUS | Pegasus      |
| SIRUBA  | Siruba       |
| YAMATO  | Yamato       |
| HASHIMA | Hashima      |
| NAOMOTO | Naomoto      |
| OTHER   | Other        |

---

## Fields

| Field       | Type         | Description       |
| ----------- | ------------ | ----------------- |
| id          | UUID         | Primary Key       |
| code        | VARCHAR(30)  | รหัสผู้ผลิต       |
| name        | VARCHAR(100) | ชื่อผู้ผลิต       |
| country     | VARCHAR(100) | ประเทศ            |
| website     | VARCHAR(255) | เว็บไซต์          |
| description | TEXT         | รายละเอียด        |
| is_active   | BOOLEAN      | เปิดใช้งาน        |
| created_at  | TIMESTAMP    | วันที่สร้าง       |
| updated_at  | TIMESTAMP    | วันที่แก้ไขล่าสุด |

---

## Business Rules

### BR-MM-001

Manufacturer Code ต้องไม่ซ้ำ

---

### BR-MM-002

Machine สามารถอ้างอิง Manufacturer ได้เพียงหนึ่งราย

---

### BR-MM-003

ห้ามลบ Manufacturer หากมี Machine ใช้งานอยู่

ให้เปลี่ยน

is_active = false

---

## Notes

Machine จะอ้างอิง Manufacturer ผ่าน

manufacturer_id
