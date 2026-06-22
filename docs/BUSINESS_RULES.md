# Business Rules

## Purpose

This document defines the business rules of the Smart Maintenance System.

It is the primary reference for database design, application development, and future system enhancements.

All developers and AI assistants must follow these rules when implementing new features.

---

# Project Objective

The Smart Maintenance System is designed to help factories manage machines, preventive maintenance, inspections, and maintenance history in a simple and mobile-friendly way.

---

# General Rules

- The system is web-based.
- The system is optimized for smartphones.
- Every user accesses the same application.
- Authentication is required.
- Every action should be traceable.

---

# Users

Current expected users

- Operators
- Technicians
- Supervisors
- Managers
- Administrators

Current version

All authenticated users can create a Work Order.

Role permissions may be expanded in future versions.

---

# Machines

Every machine must have

- Machine ID
- Machine Name
- QR Code
- Department
- Location
- Status

Each QR Code represents exactly one machine.

---

# Work Orders

Any authenticated user can create a Work Order.

A Work Order should contain

- Machine
- Problem Description
- Reporter
- Date & Time
- Status
- Assigned Technician (optional)

Each Work Order belongs to one machine.

---

# Preventive Maintenance (PM)

The system supports multiple maintenance intervals.

Current supported intervals

- Daily
- Weekly
- Monthly
- Running Hour

Additional intervals may be added in future versions.

---

# Inspection

Machines may have inspection checklists.

Inspection records should be stored for historical reference.

---

# Maintenance History

Every completed maintenance activity should become historical data.

History must never be deleted under normal operation.

---

# Attachments

Current Version

Image upload is not supported.

Future versions may support

- Photos
- PDF Documents
- Videos

---

# Notifications

Notification system is planned for future development.

Possible channels

- In-app notification
- Email
- LINE Notify (optional)

---

# Dashboard

The dashboard should summarize

- Machine Status
- PM Due
- Open Work Orders
- Completed Work Orders
- Maintenance Statistics

---

# Audit Trail

Important actions should be recorded.

Examples

- Create Work Order
- Complete Work Order
- Edit Machine Information

---

# Future Expansion

The system is designed to support

- Multiple factories
- Multiple departments
- Spare Parts
- Purchase Requests
- Inventory
- Predictive Maintenance (PdM)
- IoT Integration

---

# References

- DATABASE.md
- ARCHITECTURE.md
- ROADMAP.md
