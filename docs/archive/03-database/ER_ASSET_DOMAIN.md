# ER_ASSET_DOMAIN

## Purpose

Asset Domain เป็นหัวใจของ Smart Maintenance System

ใช้จัดเก็บข้อมูลเครื่องจักร อุปกรณ์ ชิ้นส่วน และตำแหน่งติดตั้ง

---

# Entity Relationship Overview

```text
asset_category
        │
        ▼
asset_type
        │
        ▼
machine
        ▲
        │
manufacturer
        │
        ▼
model

location
    │
    ▼
machine

machine
    │
    ▼
machine_component

machine
    │
    ▼
machine_meter
```

---

# Entity Definitions

## asset_category

กลุ่มหลักของสินทรัพย์

ตัวอย่าง

- Production Machine
- Utility Equipment
- Facility
- Vehicle
- Tooling

---

## asset_type

ประเภทสินทรัพย์ภายใต้ Category

ตัวอย่าง

Category: Production Machine

Type:

- CNC Machine
- Lathe Machine
- Milling Machine

---

## manufacturer

ผู้ผลิตเครื่องจักร

ตัวอย่าง

- Siemens
- ABB
- Mitsubishi
- FANUC

---

## model

รุ่นของเครื่องจักร

ตัวอย่าง

Manufacturer: FANUC

Models:

- ROBODRILL α-D21LiB5
- ROBOCUT C400iC

---

## location

ตำแหน่งติดตั้งเครื่องจักร

ตัวอย่าง

- Building A
- Line 1
- Line 2
- Utility Area

---

## machine

Master Record ของเครื่องจักร

ตัวอย่างข้อมูล

- Machine Code
- Machine Name
- Serial Number
- Installation Date
- Manufacturer
- Model
- Location

---

## machine_component

ส่วนประกอบของเครื่องจักร

ตัวอย่าง

- Motor
- Gearbox
- Bearing
- Pump

---

## machine_meter

ตัววัดค่าการใช้งาน

ตัวอย่าง

- Runtime Hour
- Production Counter
- Cycle Count
- Energy Consumption

---

# Relationship Rules

## asset_category → asset_type

One Category

Many Asset Types

---

## manufacturer → model

One Manufacturer

Many Models

---

## location → machine

One Location

Many Machines

---

## machine → machine_component

One Machine

Many Components

---

## machine → machine_meter

One Machine

Many Meters

---

# Design Principles

- UUID Primary Key
- Soft Delete
- Audit Columns
- Multi-Plant Support
- Supabase Compatible
- Future CMMS / EAM Expansion
