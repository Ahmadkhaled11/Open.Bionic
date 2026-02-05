# open_bionic-installer/v2.1
# Universal Installer for Open.Bionic (Windows)
# Copyright (c) 2026 Ahmadkhaled11
# Binding Contract: INV-01, INV-02, INV-03, INV-04, INV-05, INV-06, INV-08, INV-09

$ErrorActionPreference = 'Stop'

# -----------------------------------------------------------------------------
# CONSTANTS & INVARIANTS
# -----------------------------------------------------------------------------
$OrgName = "Ahmadkhaled11"
$RepoName = "Open.Bionic"
$ToolName = "open_bionic"
$GithubUrl = "https://github.com"
$InstallDir = "$env:LOCALAPPDATA\Open.Bionic"
$TempDir = [System.IO.Path]::GetTempPath() + [System.Guid]::NewGuid().ToString()

# -----------------------------------------------------------------------------
# HELPER FUNCTIONS
# -----------------------------------------------------------------------------
function Log-Info ($Message) { Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Log-Success ($Message) { Write-Host "[SUCCESS] $Message" -ForegroundColor Green }
function Log-Error ($Message) { Write-Host "[ERROR] $Message" -ForegroundColor Red; exit 1 }

# -----------------------------------------------------------------------------
# PHASE 1: DETECT ENVIRONMENT
# -----------------------------------------------------------------------------
Log-Info "Detecting environment..."
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

$Arch = "amd64" # Windows binaries provided as amd64 usually
if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") {
    $Arch = "arm64" # Future proofing
}

Log-Info "Detected: Windows / $Arch"

# -----------------------------------------------------------------------------
# PHASE 2: FETCH ARTIFACT (INV-08, INV-09)
# -----------------------------------------------------------------------------
Log-Info "Fetching latest release..."
$LatestUrl = "$GithubUrl/$OrgName/$RepoName/releases/latest/download"
$ArtifactName = "installer-windows-$Arch.exe"
$DownloadUrl = "$LatestUrl/$ArtifactName"

# Security Check: Ensure domain is github.com (INV-09)
if (-not ($DownloadUrl.StartsWith("https://github.com"))) {
    Log-Error "Security violation: Invalid check domain"
}

Log-Info "Downloading from: $DownloadUrl"
try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile "$TempDir\$ArtifactName"
} catch {
    Log-Error "Failed to download installer: $_"
}

# -----------------------------------------------------------------------------
# PHASE 3: VERIFY INTEGRITY (INV-04)
# -----------------------------------------------------------------------------
Log-Info "Verifying integrity..."

$ChecksumsUrl = "$LatestUrl/checksums.txt"
Invoke-WebRequest -Uri $ChecksumsUrl -OutFile "$TempDir\checksums.txt"

# Compute Hash
$Hash = Get-FileHash "$TempDir\$ArtifactName" -Algorithm SHA256
$ExpectedHash = Select-String -Path "$TempDir\checksums.txt" -Pattern $ArtifactName | ForEach-Object { $_.Line.Split(' ')[0] }

if ($Hash.Hash.ToLower() -ne $ExpectedHash.ToLower()) {
    Log-Error "Checksum verification failed!`nExpected: $ExpectedHash`nActual:   $($Hash.Hash)"
}

Log-Success "Integrity verified."

# -----------------------------------------------------------------------------
# PHASE 4: EXECUTE INSTALLER ENGINE
# -----------------------------------------------------------------------------
Log-Info "Launching installer engine..."

# Handover to the binary installer
Start-Process -FilePath "$TempDir\$ArtifactName" -ArgumentList "--install-dir `"$InstallDir`"" -Wait -NoNewWindow

# -----------------------------------------------------------------------------
# PHASE 5: CLEANUP
# -----------------------------------------------------------------------------
Remove-Item -Recurse -Force $TempDir
