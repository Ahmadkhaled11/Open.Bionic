# Release Notes: Open.Bionic v1.0.0-rc1

**Universal Accessibility Reading System**

## 📦 Release Artifacts (Manifest)
The following files must be included in the GitHub Release `v1.0.0-rc1`:

| Artifact | Source Path | Description |
|----------|-------------|-------------|
| **Bootstrapper (POSIX)** | `installations/bootstrap/install.sh` | Universal installer for macOS/Linux |
| **Bootstrapper (Win)** | `installations/bootstrap/install.ps1` | Universal installer for Windows |
| **Source Code** | `archive.zip` | Full source code archive |
| **Checksums** | `checksums.txt` | SHA-256 hashes of all artifacts |

## 🚀 Key Features
- **Universal Installer (v2.1)**: Single-line install for all platforms.
- **Frontend Refactor**: TypeScript + Vite, <16KB bundle size.
- **Backend Core**: Phoenix LiveView + Elixir architecture.
- **Offline Support**: Frontend Mock API mode.
- **Export Support**: PDF and RTF generation.

## 🛡️ Security & Invariants
This release enforces the **Universal Installer Binding Contract**:
- **INV-08**: No git clones during install.
- **INV-09**: All assets fetched from `github.com/.../releases/download`.
- **Integrity**: All binaries must be signed and checksummed.

## 📝 User Instructions
After publishing this release on GitHub:
1. Upload the artifacts listed above.
2. Users can install using the commands in `README.md`.
