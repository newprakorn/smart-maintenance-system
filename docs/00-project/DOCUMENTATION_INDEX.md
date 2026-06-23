# DOCUMENTATION INDEX

**Project:** Smart Maintenance System

**Version:** 1.0

**Status:** In Progress

**Document Owner:** Project Team

**Last Updated:** 2026-06-23

---

# 1. Purpose

เอกสารฉบับนี้เป็นสารบัญหลัก (Master Index) ของโครงการ Smart Maintenance System

ใช้เพื่อ

* แสดงโครงสร้างเอกสารทั้งหมด
* กำหนดลำดับการพัฒนา
* อธิบายความสัมพันธ์ระหว่างเอกสาร
* ใช้เป็นจุดเริ่มต้นสำหรับนักพัฒนา ผู้ดูแลระบบ และ AI Coding Assistant

เอกสารนี้ถือเป็นจุดอ้างอิงหลักของโปรเจกต์

---

# 2. Project Goals

Smart Maintenance System ถูกพัฒนาขึ้นเพื่อช่วยบริหารงานซ่อมบำรุงภายในโรงงานอุตสาหกรรม โดยมุ่งเน้น

* ลด Downtime ของเครื่องจักร
* เพิ่มประสิทธิภาพการซ่อมบำรุง
* รองรับ Preventive Maintenance
* ใช้ QR Code ในการระบุตัวเครื่องจักร
* ใช้งานผ่านโทรศัพท์มือถือได้
* รองรับการวิเคราะห์ข้อมูลและ AI ในอนาคต

---

# 3. Documentation Structure

```text
docs/

00-project
01-business
02-architecture
03-database
04-development
05-ui-ux
06-testing
07-api
08-deployment
```

---

# 4. Document Overview

## 00-project

เอกสารระดับโครงการ

| File                   | Description           |
| ---------------------- | --------------------- |
| ROADMAP.md             | แผนการพัฒนา           |
| AI_RULES.md            | กฎสำหรับ AI Coding    |
| CHANGELOG.md           | ประวัติการเปลี่ยนแปลง |
| DOCUMENTATION_INDEX.md | สารบัญเอกสารทั้งหมด   |

---

## 01-business

เอกสารด้านธุรกิจ

* Business Rules
* User Roles
* Workflow
* Workflow State Machine
* Master Data

---

## 02-architecture

เอกสารด้านสถาปัตยกรรมระบบ

* System Architecture
* Folder Structure
* Technology Stack

---

## 03-database

เอกสารด้านฐานข้อมูล

* Entity Catalog
* Data Dictionary
* ER Diagram
* Master Data
* Database Design

---

## 04-development

มาตรฐานการพัฒนา

* Coding Standard
* Git Workflow
* Development Guide
* Deployment Guide

---

## 05-ui-ux

การออกแบบหน้าจอและประสบการณ์ผู้ใช้

* Wireframe
* Screen Flow
* Design System
* Component Guide

---

## 06-testing

การทดสอบระบบ

* Test Plan
* Test Case
* User Acceptance Test (UAT)

---

## 07-api

เอกสาร API

* API Specification
* Authentication
* Webhooks

---

## 08-deployment

เอกสารสำหรับการติดตั้งและนำระบบขึ้นใช้งานจริง

---

# 5. Development Phases

| Phase               | Status         |
| ------------------- | -------------- |
| Project Planning    | ✅ Completed    |
| Business Analysis   | ✅ Completed    |
| Architecture Design | 🟡 In Progress |
| Database Design     | 🟡 In Progress |
| Development         | ⏳ Pending      |
| Testing             | ⏳ Pending      |
| Deployment          | ⏳ Pending      |

---

# 6. Technology Stack

| Layer           | Technology                |
| --------------- | ------------------------- |
| Frontend        | React + TypeScript + Vite |
| UI              | Tailwind CSS              |
| Backend         | Supabase                  |
| Database        | PostgreSQL                |
| Authentication  | Supabase Auth             |
| Storage         | Supabase Storage (Future) |
| Version Control | Git + GitHub              |
| CI/CD           | GitHub Actions            |
| Hosting         | GitHub Pages              |

---

# 7. Documentation Rules

1. ทุกเอกสารต้องมี Purpose
2. ทุกเอกสารต้องมี Version
3. ทุกเอกสารต้องอ้างอิงข้อมูลจากเอกสารที่เกี่ยวข้อง
4. หลีกเลี่ยงข้อมูลซ้ำระหว่างเอกสาร
5. ใช้ชื่อ Table, Field และ Entity ให้ตรงกันทุกไฟล์
6. ห้ามลบข้อมูลที่ถูกใช้อ้างอิง ให้ใช้การปรับสถานะแทน
7. ทุกการเปลี่ยนแปลงสำคัญต้องบันทึกใน CHANGELOG.md

---

# 8. Current Project Status

## Completed

* Project Structure
* Business Workflow
* Workflow State Machine
* Entity Discovery
* Asset Domain Design
* Master Data Catalog

## In Progress

* Architecture Documentation
* Database Documentation

## Pending

* API Specification
* UI/UX Design
* Frontend Development
* Backend Development
* Testing
* Deployment

---

# 9. Next Milestone

Documentation v1.0

เมื่อเอกสารทุกชุดเสร็จสมบูรณ์ จะเริ่ม

1. สร้าง Database บน Supabase
2. พัฒนา Backend
3. พัฒนา Frontend
4. ทดสอบระบบ
5. Deploy ใช้งานจริง

---

**End of Document**
