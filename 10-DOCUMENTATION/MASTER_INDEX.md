# Open.Bionic Master Documentation Index

> **Version:** 1.0.0-rc1
> **Status:** Release Candidate

---

## 📚 Core Documentation

| Document | Description | Audience |
|----------|-------------|----------|
| [README.md](../README.md) | Project Overview & Quick Install | All |
| [INSTALLATION.md](../INSTALLATION.md) | Detailed Setup Guide | Developers |
| [RELEASE_NOTES.md](../RELEASE_NOTES.md) | Version History & Artifacts | All |
| [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) | Cheat Sheet for Commands | Users |

## 🏗️ Squad Specifications

### 01. Orchestrator
- [Project Vision](../01-ORCHESTRATOR/VISION.md)
- [Squad Architecture](../01-ORCHESTRATOR/SQUADS.md)

### 02. Discovery
- [Research Findings](../02-DISCOVERY-SQUAD/RESEARCH.md)
- [Requirements](../02-DISCOVERY-SQUAD/REQUIREMENTS.md)

### 03. Design
- [UI/UX Spec](../installations/specs/frontend_spec.md) (*Ref*)
- [Brand System](../03-DESIGN-SQUAD/BRAND.md)

### 04. Building
- [Backend Spec](../installations/specs/backend_spec.md) (*Ref*)
- [Database Schema](../installations/specs/database_spec.md) (*Ref*)
- [Frontend Architecture](../installations/specs/frontend_spec.md) (*Ref*)

### 05. Quality
- [Test Plan](../05-QA-TESTING-SQUAD/TEST_PLAN.md)
- [Performance Targets](../05-QA-TESTING-SQUAD/PERFORMANCE.md)

### 06. Security & DevOps
- [Installer Spec](../installations/specs/installer_spec.md)
- [Threat Model](../06-SECURITY-SQUAD/THREAT_MODEL.md)
- [CI/CD Pipeline](../installations/ci/installer-policy.yml)

---

## 🛠️ Developer Resources

### Commands
- **Frontend Build:** `cd frontend && npm run build`
- **Backend Test:** `cd open_bionic_lib && mix test`
- **Installer Build:** `go build -o open_bionic installations/core/main.go`

### Directory Structure
```
Open.Bionic/
├── open_bionic_lib/   # Phoenix Backend
├── frontend/          # Vite Frontend
├── installations/     # Universal Installer
│   ├── bootstrap/
│   ├── core/
│   └── ci/
└── 10-DOCUMENTATION/  # You are here
```
