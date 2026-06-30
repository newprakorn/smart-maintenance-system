# MASTER_DATA_DESIGN

## Objective

กำหนดมาตรฐานการออกแบบ Master Data สำหรับ Smart Maintenance System

---

# Asset Master Data

## asset_category

| Field         | Type         |
| ------------- | ------------ |
| id            | UUID         |
| category_code | VARCHAR(50)  |
| category_name | VARCHAR(255) |
| description   | TEXT         |

---

## asset_type

| Field       | Type         |
| ----------- | ------------ |
| id          | UUID         |
| category_id | UUID         |
| type_code   | VARCHAR(50)  |
| type_name   | VARCHAR(255) |
| description | TEXT         |

---

## manufacturer

| Field             | Type         |
| ----------------- | ------------ |
| id                | UUID         |
| manufacturer_code | VARCHAR(50)  |
| manufacturer_name | VARCHAR(255) |
| country           | VARCHAR(100) |

---

## model

| Field           | Type         |
| --------------- | ------------ |
| id              | UUID         |
| manufacturer_id | UUID         |
| model_code      | VARCHAR(100) |
| model_name      | VARCHAR(255) |

---

## location

| Field         | Type         |
| ------------- | ------------ |
| id            | UUID         |
| plant_id      | UUID         |
| location_code | VARCHAR(50)  |
| location_name | VARCHAR(255) |

---

## machine

| Field             | Type         |
| ----------------- | ------------ |
| id                | UUID         |
| machine_code      | VARCHAR(50)  |
| machine_name      | VARCHAR(255) |
| asset_type_id     | UUID         |
| manufacturer_id   | UUID         |
| model_id          | UUID         |
| location_id       | UUID         |
| serial_number     | VARCHAR(100) |
| installation_date | DATE         |

---

## machine_component

| Field          | Type         |
| -------------- | ------------ |
| id             | UUID         |
| machine_id     | UUID         |
| component_code | VARCHAR(50)  |
| component_name | VARCHAR(255) |

---

## machine_meter

| Field      | Type         |
| ---------- | ------------ |
| id         | UUID         |
| machine_id | UUID         |
| meter_code | VARCHAR(50)  |
| meter_name | VARCHAR(255) |
| meter_unit | VARCHAR(50)  |

---

# Common Standards

ทุก Master Data Table ต้องมี

| Field      |
| ---------- |
| is_active  |
| created_at |
| updated_at |
| deleted_at |
| created_by |
| updated_by |

---

# Naming Convention

Primary Key

```sql
id UUID PRIMARY KEY
```

Foreign Key

```sql
asset_type_id
manufacturer_id
location_id
machine_id
```

Unique Code

```sql
*_code
```

Display Name

```sql
*_name
```

---

# Database Standards

- UUID Primary Key
- Soft Delete
- Audit Trail
- Trigger updated_at
- Supabase Compatible
- PostgreSQL 17 Compatible
