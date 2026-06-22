# Development Guide

## Purpose

This document explains how to set up, run, maintain, and contribute to the Smart Maintenance System project.

It serves as the primary guide for developers working on this repository.

---

# Project Overview

Project Name

> Smart Maintenance System

Technology Stack

- React 19
- TypeScript
- Vite
- Tailwind CSS v4
- React Router
- Supabase
- pnpm Workspace
- GitHub Actions
- GitHub Pages

---

# Development Environment

Required Software

- Git
- Node.js 24 LTS
- pnpm 11+
- Visual Studio Code

Recommended Extensions

- ESLint
- Prettier
- Tailwind CSS IntelliSense
- GitHub Copilot
- GitLens

---

# Project Structure

```
apps/
    web/

docs/

.github/

package.json
```

---

# Installation

Clone repository

```
git clone https://github.com/newprakorn/smart-maintenance-system.git
```

Install packages

```
pnpm install
```

---

# Environment Variables

Create

```
apps/web/.env.local
```

Example

```
VITE_SUPABASE_URL=YOUR_URL
VITE_SUPABASE_ANON_KEY=YOUR_KEY
```

Never commit real credentials.

---

# Development Commands

Run Development Server

```
pnpm dev
```

Lint

```
pnpm lint
```

Type Check

```
pnpm typecheck
```

Build

```
pnpm build
```

---

# Git Workflow

Before starting work

```
git pull
```

After finishing work

```
git add .

git commit -m "type: message"

git push
```

Example

```
git commit -m "feat: add machine page"
```

---

# Branch Strategy

Current

- main

Future

- develop
- feature/\*
- hotfix/\*

---

# Code Quality

Every commit must pass

- ESLint
- TypeScript
- GitHub Actions

Never bypass CI checks.

---

# Documentation

Every major feature should update:

- ROADMAP.md
- DATABASE.md
- BUSINESS_RULES.md

when applicable.

---

# References

- AI_RULES.md
- CODING_STANDARD.md
- ARCHITECTURE.md
- DATABASE.md
