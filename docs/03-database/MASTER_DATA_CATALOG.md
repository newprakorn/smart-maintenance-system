# MASTER_DATA_CATALOG

## Phase

5.3C – Master Data Catalog

---

# Purpose

Master Data Catalog เป็นเอกสารที่รวบรวมข้อมูลหลัก (Master Data) ทั้งหมดของระบบ Smart Maintenance System

ใช้เป็นมาตรฐานในการออกแบบฐานข้อมูล การพัฒนาระบบ และการกำหนดสิทธิ์ในการจัดการข้อมูล

---

# Objectives

- รวบรวม Master Data ทั้งหมดของระบบ
- ลดข้อมูลซ้ำ (Data Duplication)
- กำหนด Owner ของข้อมูลแต่ละประเภท
- กำหนดสิทธิ์ในการเพิ่ม แก้ไข และปิดการใช้งาน
- ใช้เป็นมาตรฐานในการสร้างฐานข้อมูลจริง

---

# Master Data Principles

ทุก Master Data

- มี Primary Key (UUID)
- มี Code
- มี Name
- รองรับการเปิด/ปิดการใช้งาน (is_active)
- ห้ามลบข้อมูลที่ถูกใช้งานแล้ว
- ใช้ Foreign Key ใน Transaction Tables

---

# Standard Fields

ทุก Master Table ควรมี

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

# Master Data Groups

1. Asset Master
2. Organization Master
3. Maintenance Master
4. Calendar Master
5. Security Master

---

Status

Draft

Version 1.0

# 1. Asset Master

Asset Master ใช้เก็บข้อมูลพื้นฐานของเครื่องจักร

| Master                | Owner               | Editable |
| --------------------- | ------------------- | -------- |
| Machine Types         | Maintenance Manager | Yes      |
| Machine Categories    | Maintenance Manager | Yes      |
| Machine Manufacturers | Maintenance Manager | Yes      |
| Machine Models        | Maintenance Manager | Yes      |
| Machine Criticalities | Maintenance Manager | Yes      |
| Machine Statuses      | Maintenance Manager | Yes      |

---

# 2. Organization Master

ใช้กำหนดโครงสร้างของโรงงาน

| Master           | Owner         | Editable |
| ---------------- | ------------- | -------- |
| Factories        | Administrator | Yes      |
| Departments      | Administrator | Yes      |
| Production Lines | Administrator | Yes      |
| Cost Centers     | Administrator | Yes      |

---

# 3. Maintenance Master

ใช้สำหรับงานซ่อมและ PM

| Master                | Owner               | Editable |
| --------------------- | ------------------- | -------- |
| Work Order Statuses   | Maintenance Manager | Yes      |
| Work Order Priorities | Maintenance Manager | Yes      |
| Failure Codes         | Maintenance Manager | Yes      |
| Failure Causes        | Maintenance Manager | Yes      |
| Corrective Actions    | Maintenance Manager | Yes      |
| PM Types              | Maintenance Manager | Yes      |
| PM Frequencies        | Maintenance Manager | Yes      |

---

# 4. Calendar Master

ใช้สำหรับการวางแผน PM และการคำนวณ KPI

| Master            | Owner         | Editable |
| ----------------- | ------------- | -------- |
| Working Calendars | Administrator | Yes      |
| Holidays          | Administrator | Yes      |
| Shift Patterns    | Administrator | Yes      |

---

# 5. Security Master

ใช้กำหนดสิทธิ์การใช้งานระบบ

| Master           | Owner         | Editable |
| ---------------- | ------------- | -------- |
| Roles            | Administrator | Yes      |
| Permissions      | Administrator | Yes      |
| Menu Permissions | Administrator | Yes      |
