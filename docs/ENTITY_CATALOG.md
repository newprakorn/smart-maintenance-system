# ENTITY CATALOG

## Smart Maintenance System

Version 1.0

---

# Purpose

เอกสารนี้อธิบาย Entity ทั้งหมดที่ใช้ภายใน Smart Maintenance System

ใช้เป็นมาตรฐานก่อนออกแบบ Database, Supabase Schema และ Frontend

---

# 1. Users

Description

ผู้ใช้งานระบบ

Examples

- Operator
- Line Leader
- Technician
- Admin

Owner

System

Priority

★★★★★

---

# 2. Roles

Description

สิทธิ์การใช้งานของผู้ใช้

Examples

- Admin
- Technician
- Leader
- Operator

Owner

System

Priority

★★★★★

---

# 3. Departments

Description

แผนกภายในโรงงาน

Examples

- Sewing
- Cutting
- Finishing
- Packing
- Maintenance

Owner

Factory

Priority

★★★★★

---

# 4. Production Lines

Description

ไลน์การผลิตภายในแต่ละแผนก

Examples

- Line A
- Line B
- Line 1
- Line 2

Owner

Production

Priority

★★★★★

---

# 5. Machine Types

Description

ประเภทของเครื่องจักร

Examples

- จักรเข็มเดี่ยว
- จักรเข็มคู่
- จักรโพ้ง
- เครื่องตัด
- เตารีด
- Boiler

Owner

Maintenance

Priority

★★★★★

---

# 6. Machines

Description

ข้อมูลเครื่องจักรทั้งหมด

Examples

MC-SNJ-MAC-111

MC-DNJ-MAC-015

MC-OLJ-MAC-008

Owner

Maintenance

Priority

★★★★★

---

# 7. Work Orders

Description

รายการแจ้งซ่อม

Lifecycle

Open

↓

Accepted

↓

In Progress

↓

Waiting Confirmation

↓

Completed

Owner

Maintenance

Priority

★★★★★

---

# 8. Work Order Status History

Description

เก็บประวัติการเปลี่ยนสถานะทุกครั้ง

Purpose

Audit

Tracking

KPI

Owner

System

Priority

★★★★☆

---

# 9. Failure Categories

Description

หมวดหมู่อาการเสีย

Examples

- Electrical
- Mechanical
- Needle
- Motor
- Sensor

Owner

Maintenance

Priority

★★★★★

Remark

เลือกโดยช่างตอนปิดงาน

---

# 10. PM Plans

Description

แผน Preventive Maintenance

Examples

- Daily
- Weekly
- Monthly
- Running Hour

Owner

Maintenance

Priority

★★★★★

---

# 11. PM Schedules

Description

รายการ PM ที่ระบบสร้างตามแผน

Owner

System

Priority

★★★★☆

---

# 12. Spare Parts

Description

รายการอะไหล่ทั้งหมด

Owner

Maintenance

Priority

★★★★★

---

# 13. Spare Usage

Description

ประวัติการใช้อะไหล่ในแต่ละ Work Order

Owner

Maintenance

Priority

★★★★☆

---

# Version 1 Scope

Included

✓ User Management

✓ Machine Management

✓ QR Code

✓ Work Orders

✓ PM

✓ Failure Categories

✓ Spare Parts

✓ Dashboard

Not Included

✗ IoT

✗ Image Upload

✗ Chat

✗ Vendor

✗ Purchase Request

✗ Calibration

✗ Predictive Maintenance
