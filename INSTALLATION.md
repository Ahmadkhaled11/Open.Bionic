# Open.Bionic Installation Guide

## Prerequisites Installation

### Step 1: Install Elixir & Erlang (Windows)

**Option A: Using Chocolatey (Recommended)** - Requires Admin Rights

```powershell
# Run PowerShell as Administrator
choco install elixir -y
```

**Option B: Using Direct Installers**

1. Download Erlang/OTP 26: https://www.erlang.org/downloads
2. Download Elixir 1.15: https://github.com/elixir-lang/elixir/releases
3. Install both in order (Erlang first, then Elixir)
4. Add to PATH if not automatically added

```powershell
elixir --version
mix --version
```

### Step# 🛠️ Installation & Setup Guide

## Prerequisites

3. **PostgreSQL**: [Download v15+](https://www.postgresql.org/download/) (Optional for frontend-only dev)
4. **Git**: [Download](https://git-scm.com/)

## ⚡ Automated Setup (Windows)

Run the included setup script to install dependencies automatically:

```powershell
.\setup.ps1
```

Or double-click `setup.bat`.


---

## 🚀 Quick Start (Frontend Only)

The frontend is designed to work standalone with a mock API for development.

1. **Navigate to the frontend directory:**
   ```powershell
   cd frontend
   ```

2. **Install dependencies:**
   ```powershell
   npm install
   ```

3. **Start the development server:**
   ```powershell
   npm run dev
   ```

   > Access the app at **http://localhost:3000**

---

## ⚡ Full Stack Setup

### 1. Backend Setup (Elixir/Phoenix)

> **Note:** Requires Elixir and PostgreSQL installed.

1. **Navigate to backend directory:**
   ```powershell
   cd open_bionic_lib
   ```

2. **Install dependencies:**
   ```powershell
   mix deps.get
   ```

3. **Setup Database:**
   ```powershell
   mix ecto.setup
   ```

4. **Start Server:**
   ```powershell
   mix phx.server
   ```
   > API runs on **http://localhost:4000**

### 2. Frontend Integration

1. **Navigate to frontend:**
   ```powershell
   cd frontend
   ```

2. **Start with API mode:**
   ```powershell
   npm run dev
   ```
   The frontend will automatically detect the backend at `http://localhost:4000`.

---

## 🐳 Docker Setup (Recommended for Deployment)

Build and run the entire stack (Frontend + Backend + Database) with one command:

```powershell
docker-compose up --build
```

- Frontend: http://localhost:3000
- Backend: http://localhost:4000
- Database: port 5432

---

## ✅ Verification

- [ ] **Frontend**: Open `http://localhost:3000` - should see "Open|Bionic"
- [ ] **Backend**: Get `http://localhost:4000/api/v1/health` - should return JSON
- [ ] **Tests**: Run `npm run type-check` in frontend folder
