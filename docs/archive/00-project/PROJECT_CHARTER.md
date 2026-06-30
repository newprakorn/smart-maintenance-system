# PROJECT CHARTER

**Project:** Smart Maintenance System

**Version:** 1.0

**Status:** In Progress

**Document Owner:** Project Team

**Last Updated:** 2026-06-23

---

# 1. Project Overview

Smart Maintenance System เป็นระบบบริหารงานซ่อมบำรุงเครื่องจักรสำหรับโรงงานอุตสาหกรรม โดยออกแบบให้ใช้งานผ่านโทรศัพท์มือถือและเว็บเบราว์เซอร์

ระบบมุ่งเน้นการจัดการงานซ่อม (Corrective Maintenance) และงานบำรุงรักษาเชิงป้องกัน (Preventive Maintenance) พร้อมรองรับการขยายไปสู่การวิเคราะห์ข้อมูลและระบบอัจฉริยะในอนาคต

---

# 2. Vision

สร้างระบบ Smart Maintenance ที่ใช้งานง่าย รวดเร็ว และสามารถลด Downtime ของเครื่องจักร พร้อมรองรับการเติบโตของโรงงานในระยะยาว

---

# 3. Project Objectives

- ลดเวลาการแจ้งซ่อม
- ลดเวลาหยุดเครื่องจักร (Downtime)
- จัดเก็บประวัติการซ่อมแบบครบถ้วน
- รองรับ Preventive Maintenance หลายรูปแบบ
- ใช้ QR Code ระบุเครื่องจักร
- รองรับการวิเคราะห์ KPI และ Dashboard
- รองรับการขยายระบบในอนาคต

---

# 4. Project Scope

## In Scope

- Asset Management
- Work Order Management
- Preventive Maintenance
- QR Code
- Machine History
- Machine Location History
- Waiting Parts Workflow
- Dashboard
- Reporting
- User & Role Management
- Master Data Management

---

## Out of Scope (Version 1)

- IoT Integration
- Predictive Maintenance
- AI Failure Prediction
- Image Storage
- Purchasing System
- ERP Integration

---

# 5. Target Users

| Role                   | Description                    |
| ---------------------- | ------------------------------ |
| Operator               | แจ้งซ่อมผ่าน QR Code           |
| Technician             | รับงานและซ่อมเครื่อง           |
| Maintenance Supervisor | ตรวจสอบและติดตามงาน            |
| Maintenance Manager    | วิเคราะห์ KPI และบริหารงานซ่อม |
| Administrator          | จัดการระบบและข้อมูลหลัก        |

---

# 6. Factory Structure

ระบบรองรับโครงสร้างโรงงานดังนี้

Factory

↓

Department

↓

Production Line

↓

Machine

Machine สามารถย้ายข้าม Production Line และ Department ได้ โดยต้องเก็บประวัติการย้ายทุกครั้ง

---

# 7. Machine Identification Standard

Machine Code เป็นรหัสหลักของเครื่องจักร

ตัวอย่าง

- MC-SNJ-MAC-111
- MC-DNJ-MAC-015
- MC-OLJ-MAC-008

Machine Code จะไม่เปลี่ยนตลอดอายุการใช้งานของเครื่องจักร

---

# 8. Maintenance Scope

รองรับ

## Corrective Maintenance (CM)

- Breakdown
- Emergency Repair
- Adjustment

## Preventive Maintenance (PM)

- Daily
- Weekly
- Monthly
- Quarterly
- Semi-Annual
- Annual
- Running Hours
- Machine Counter

---

# 9. Work Order Workflow

Draft

↓

Open

↓

Assigned

↓

In Progress

↓

Waiting Parts

↓

Testing

↓

Completed

↓

Closed

↓

Cancelled

---

# 10. Technology Stack

| Layer          | Technology         |
| -------------- | ------------------ |
| Frontend       | React + TypeScript |
| UI             | Tailwind CSS       |
| Backend        | Supabase           |
| Database       | PostgreSQL         |
| Authentication | Supabase Auth      |
| Repository     | GitHub             |
| CI/CD          | GitHub Actions     |

---

# 11. Success Criteria

โครงการจะถือว่าประสบความสำเร็จเมื่อ

- ผู้แจ้งสามารถสร้าง Work Order ผ่าน QR Code ได้
- ช่างสามารถรับงานและปิดงานผ่านมือถือได้
- ระบบรองรับ PM ครบตามแผน
- Dashboard แสดง KPI ได้
- ระบบสามารถขยายไปยัง Inventory, IoT และ AI ได้โดยไม่ต้องรื้อฐานข้อมูล

---

# 12. Project Principles

1. Mobile First
2. QR Code First
3. Master Data Driven
4. Workflow Based
5. Audit Trail ทุกการเปลี่ยนแปลง
6. Soft Delete แทนการลบข้อมูล
7. UUID เป็น Primary Key ทุกตาราง
8. รองรับการขยายระบบในอนาคต

---

# 13. Assumptions

- มีโรงงาน 1 แห่ง (Version 1)
- รองรับหลาย Department
- รองรับหลาย Production Line
- จำนวนเครื่องจักรประมาณ 100–500 เครื่อง
- ผู้ใช้งานหลักผ่านโทรศัพท์มือถือ
- ไม่มีการจัดเก็บรูปภาพใน Version 1

---

# 14. Future Roadmap

Version 2

- Spare Parts Inventory
- Purchase Request
- Vendor Management
- MTBF / MTTR Analytics

Version 3

- IoT
- Predictive Maintenance
- AI Recommendation
- Power BI Integration

---

# Related Documents

- DOCUMENTATION_INDEX.md
- ROADMAP.md
- BUSINESS_RULES.md
- SYSTEM_ARCHITECTURE.md
- DATABASE.md

---

**End of Document**
