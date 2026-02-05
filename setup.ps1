# Open.Bionic "One-Click" Developer Setup
# Usage: .\setup.ps1

$ErrorActionPreference = "Stop"

function Write-Step { param($msg) Write-Host "`n🔹 $msg" -ForegroundColor Cyan }
function Write-Success { param($msg) Write-Host "✅ $msg" -ForegroundColor Green }
function Write-ErrorMsg { param($msg) Write-Host "❌ $msg" -ForegroundColor Red }

# 1. Check Prerequisites
Write-Step "Checking prerequisites..."

# Check Node.js
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Success "Node.js detected ($(node --version))"
}
else {
    Write-ErrorMsg "Node.js not found. Please install from https://nodejs.org/"
    exit 1
}

# Check Elixir (Optional but recommended)
if (Get-Command elixir -ErrorAction SilentlyContinue) {
    Write-Success "Elixir detected ($(elixir --version))"
}
else {
    Write-Host "⚠️  Elixir not found. Backend will require Docker." -ForegroundColor Yellow
}

# 2. Setup Frontend
Write-Step "Setting up Frontend..."
if (Test-Path "frontend") {
    Push-Location "frontend"
    try {
        Write-Host "Installing npm dependencies..."
        npm install
        Write-Success "Frontend dependencies installed."
    }
    catch {
        Write-ErrorMsg "Failed to install frontend dependencies."
    }
    finally {
        Pop-Location
    }
}
else {
    Write-ErrorMsg "Frontend directory not found!"
}

# 3. Setup Backend (if Elixir exists)
if (Get-Command mix -ErrorAction SilentlyContinue) {
    Write-Step "Setting up Backend..."
    if (Test-Path "open_bionic_lib") {
        Push-Location "open_bionic_lib"
        try {
            Write-Host "Installing Mix dependencies..."
            mix deps.get
            
            Write-Host "Compiling..."
            mix compile
            
            Write-Success "Backend ready."
        }
        catch {
            Write-ErrorMsg "Backend setup failed. (Is PostgreSQL running?)"
        }
        finally {
            Pop-Location
        }
    }
}

Write-Host "`n🎉 Setup Complete!" -ForegroundColor Green
Write-Host "To start the app:"
Write-Host "1. Frontend:  cd frontend; npm run dev"
Write-Host "2. Backend:   cd open_bionic_lib; mix phx.server"
