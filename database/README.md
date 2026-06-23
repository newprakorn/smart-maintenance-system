# Database

Project

Smart Maintenance System (SMS)

---

## Purpose

โฟลเดอร์นี้ใช้จัดเก็บทุกอย่างที่เกี่ยวข้องกับฐานข้อมูล

* SQL Migration
* Database Schema
* Seed Data
* Views
* Functions
* Triggers
* Indexes

ทุกการเปลี่ยนแปลงฐานข้อมูลต้องถูกจัดเก็บไว้ใน Git Repository

ห้ามสร้างตารางผ่านหน้า Dashboard ของ Supabase โดยตรง ยกเว้นกรณีทดสอบชั่วคราว

---

## Folder Structure

```text
database

├── migrations
├── schema
├── seed
└── README.md
```

---

## Development Rules

* Database First
* Migration First
* Git Version Control
* UUID Primary Key
* Soft Delete
* Audit Trail

---

## Migration Naming

ตัวอย่าง

001_initial_schema.sql

002_master_data.sql

003_asset_module.sql

004_work_order.sql

005_pm_module.sql

...

---

## Related Documents

docs/03-database/
