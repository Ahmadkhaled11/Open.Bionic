# Open.Bionic Backend Setup Script
# Run this after installing Elixir and Phoenix

Write-Host "Setting up Open.Bionic Phoenix Backend..." -ForegroundColor Cyan

# Check if mix is available
try {
    $null = mix --version
} catch {
    Write-Host "ERROR: Elixir/Mix not found. Please install Elixir first." -ForegroundColor Red
    Write-Host "See INSTALLATION.md for instructions" -ForegroundColor Yellow
    exit 1
}

# Create Phoenix project
Write-Host "`nCreating Phoenix LiveView project..." -ForegroundColor Green
mix phx.new open_bionic_lib --live --database postgres --no-install

# Navigate to project
Set-Location open_bionic_lib

# Update mix.exs with additional dependencies
Write-Host "`nAdding dependencies..." -ForegroundColor Green

$mixContent = Get-Content mix.exs -Raw
$mixContent = $mixContent -replace '(defp deps do\s+\[)', @'
$1
      {:pdf_generator, "~> 0.7"},
      {:cors_plug, "~> 3.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
'@

Set-Content -Path mix.exs -Value $mixContent

# Install dependencies
Write-Host "`nInstalling dependencies..." -ForegroundColor Green
mix deps.get

# Create database
Write-Host "`nCreating database (ensure PostgreSQL is running)..." -ForegroundColor Green
try {
    mix ecto.create
} catch {
    Write-Host "WARNING: Could not create database. Ensure PostgreSQL is running." -ForegroundColor Yellow
}

Write-Host "`n✅ Backend setup complete!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. cd open_bionic_lib" -ForegroundColor White
Write-Host "  2. mix phx.server" -ForegroundColor White
