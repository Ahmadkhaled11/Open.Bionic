# Open.Bionic Frontend Setup Script
# Run this after installing Node.js

Write-Host "Setting up Open.Bionic TypeScript Frontend..." -ForegroundColor Cyan

# Check if npm is available
try {
    $null = npm --version
} catch {
    Write-Host "ERROR: Node.js/npm not found. Please install Node.js first." -ForegroundColor Red
    Write-Host "See INSTALLATION.md for instructions" -ForegroundColor Yellow
    exit 1
}

# Create frontend directory
Write-Host "`nCreating Vite + TypeScript project..." -ForegroundColor Green
npm create vite@latest frontend -- --template vanilla-ts

# Navigate to frontend
Set-Location frontend

# Install dependencies
Write-Host "`nInstalling dependencies..." -ForegroundColor Green
npm install

# Install additional packages
Write-Host "`nAdding additional packages..." -ForegroundColor Green
npm install -D @playwright/test vitest

Write-Host "`n✅ Frontend setup complete!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. cd frontend" -ForegroundColor White
Write-Host "  2. npm run dev" -ForegroundColor White
