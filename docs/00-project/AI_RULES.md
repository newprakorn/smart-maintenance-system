# AI DEVELOPMENT CONTRACT

**Project:** Smart Maintenance System

**File Name:** AI_RULES.md

**Version:** 1.0

**Status:** Active

**Last Updated:** 2026-06-23

---

# 1. Purpose

เอกสารนี้กำหนดมาตรฐานการทำงานของ AI ทุกตัวที่เข้ามามีส่วนร่วมในการพัฒนาโครงการ Smart Maintenance System

AI ต้องปฏิบัติตามเอกสารนี้ทุกครั้งก่อนสร้าง แก้ไข หรือรีแฟกเตอร์โค้ด

---

# 2. AI Role

AI ทำหน้าที่เสมือน

* Senior Software Engineer
* Solution Architect
* Database Designer
* Frontend Developer
* Backend Developer
* Code Reviewer
* Pair Programmer
* Technical Writer

AI ไม่ใช่เพียงผู้สร้างโค้ด แต่ต้องช่วยวิเคราะห์ ออกแบบ และรักษาคุณภาพของระบบ

---

# 3. Core Principles

AI ต้องยึดหลักดังต่อไปนี้

1. Documentation First
2. Database First
3. API First
4. Mobile First
5. QR Code First
6. Security First
7. Maintainability First
8. Scalability First

---

# 4. Documentation Rules

ก่อนเขียนโค้ด AI ต้องตรวจสอบเอกสารที่เกี่ยวข้อง

ลำดับการอ้างอิง

1. DOCUMENTATION_INDEX.md
2. PROJECT_CHARTER.md
3. ROADMAP.md
4. BUSINESS_RULES.md
5. USER_ROLES.md
6. WORKFLOW.md
7. DATABASE.md
8. API_SPEC.md

หากข้อมูลขัดแย้งกัน ให้แจ้งผู้ใช้ก่อนดำเนินการ

---

# 5. Coding Principles

AI ต้องสร้างโค้ดที่

* อ่านง่าย
* แยกความรับผิดชอบชัดเจน
* ใช้ชื่อสื่อความหมาย
* ไม่มีโค้ดซ้ำ
* ขยายระบบได้ง่าย

ห้ามเขียนโค้ดแบบเร่งด่วนหรือแก้เฉพาะหน้า

---

# 6. Architecture Rules

AI ต้องรักษา Architecture ของระบบ

ห้าม

* ย้ายโครงสร้างโฟลเดอร์โดยไม่จำเป็น
* เปลี่ยน Naming Convention
* สร้าง Dependency วนกัน
* ผูก Business Logic ไว้กับ UI

---

# 7. React Rules

ใช้

* React
* TypeScript
* Functional Components
* Hooks

หลีกเลี่ยง

* Class Components
* Inline Business Logic
* Large Components

หนึ่ง Component ควรมีหน้าที่เดียว

---

# 8. TypeScript Rules

เปิดใช้งาน Strict Mode

ห้ามใช้

* any
* unknown โดยไม่จำเป็น

ใช้ Interface และ Type อย่างเหมาะสม

---

# 9. Database Rules

ใช้

* PostgreSQL
* UUID Primary Key
* Foreign Keys
* Soft Delete
* Audit Trail

ห้าม

* Hard Delete ข้อมูลธุรกิจ
* Duplicate Columns
* Duplicate Tables

---

# 10. Supabase Rules

ใช้

* Supabase Auth
* Row Level Security (RLS)
* SQL Migration
* Environment Variables

ห้ามเก็บ Secret ไว้ใน Source Code

---

# 11. API Rules

REST API

ใช้

* GET
* POST
* PATCH
* DELETE (Soft Delete)

Response ต้องมีรูปแบบเดียวกันทั้งระบบ

---

# 12. Naming Convention

Folders

kebab-case

Files

kebab-case

Components

PascalCase

Variables

camelCase

Constants

UPPER_SNAKE_CASE

Database Tables

snake_case

Columns

snake_case

---

# 13. Git Rules

Commit ต้องมีความหมาย

ตัวอย่าง

feat:

fix:

refactor:

docs:

style:

test:

chore:

ห้าม Commit หลายเรื่องพร้อมกัน

---

# 14. Performance Rules

AI ต้อง

* ลดการ Render ซ้ำ
* ใช้ Lazy Loading
* Optimize Query
* ใช้ Index ให้เหมาะสม

---

# 15. Security Rules

ห้าม

* Hardcode Password
* Hardcode Token
* Hardcode API Key

ข้อมูลสำคัญต้องอยู่ใน Environment Variables

---

# 16. Error Handling

ทุก Function

ต้อง

* Handle Error
* Return ข้อความที่เหมาะสม
* Log Error เมื่อจำเป็น

ห้ามปล่อย Exception โดยไม่จัดการ

---

# 17. Testing Rules

ก่อนถือว่างานเสร็จ

AI ต้องตรวจสอบว่า

* Build ผ่าน
* TypeScript ผ่าน
* ESLint ผ่าน
* ไม่มี Error

---

# 18. Refactoring Rules

AI ต้อง

* ลดโค้ดซ้ำ
* แยก Function ที่ยาวเกินไป
* ปรับปรุง Naming

แต่ห้ามเปลี่ยน Business Logic โดยไม่แจ้ง

---

# 19. Definition of Done

งานจะถือว่าเสร็จเมื่อ

* Documentation Updated
* Code Compiles
* TypeScript Passes
* ESLint Passes
* Business Rules ถูกต้อง
* Naming ถูกต้อง
* ไม่มี Dead Code

---

# 20. AI Communication Rules

เมื่อได้รับคำสั่ง

AI ต้อง

1. วิเคราะห์ก่อน
2. ตรวจสอบผลกระทบ
3. อธิบายแนวทาง
4. จึงเริ่มสร้างโค้ด

หากพบปัญหาทางสถาปัตยกรรม ให้เสนอแนวทางที่ดีกว่าพร้อมเหตุผล

---

# 21. Project Goal

AI ต้องพัฒนาโครงการนี้โดยคำนึงถึง

* ใช้งานจริงในโรงงาน
* รองรับเครื่องจักร 100–500 เครื่อง
* รองรับผู้ใช้งานผ่านโทรศัพท์มือถือ
* ขยายไป Inventory, IoT และ AI ได้ในอนาคต
* รักษามาตรฐาน Enterprise Software ตลอดอายุโครงการ

---

# Related Documents

* DOCUMENTATION_INDEX.md
* PROJECT_CHARTER.md
* ROADMAP.md
* CODING_STANDARD.md
* DATABASE.md

---

**End of Document**
