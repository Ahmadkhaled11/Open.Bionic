#!/bin/sh
set -e

# open_bionic-installer/v2.1
# Universal Installer for Open.Bionic
# Copyright (c) 2026 Ahmadkhaled11
# Binding Contract: INV-01, INV-02, INV-03, INV-04, INV-05, INV-06, INV-08, INV-09

# -----------------------------------------------------------------------------
# CONSTANTS & INVARIANTS
# -----------------------------------------------------------------------------
ORG_NAME="Ahmadkhaled11"
REPO_NAME="Open.Bionic"
TOOL_NAME="open_bionic"
GITHUB_URL="https://github.com"
INSTALL_DIR="$HOME/.open_bionic"
TEMP_DIR=$(mktemp -d)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# -----------------------------------------------------------------------------
# HELPER FUNCTIONS
# -----------------------------------------------------------------------------
log() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# -----------------------------------------------------------------------------
# PHASE 1: DETECT ENVIRONMENT
# -----------------------------------------------------------------------------
log "Detecting environment..."
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) error "Unsupported architecture: $ARCH" ;;
esac

case "$OS" in
  linux|darwin) ;;
  *) error "Unsupported OS: $OS" ;;
esac

log "Detected: $OS / $ARCH"

# -----------------------------------------------------------------------------
# PHASE 2: FETCH ARTIFACT (INV-08, INV-09)
# -----------------------------------------------------------------------------
log "Fetching latest release..."
LATEST_URL="$GITHUB_URL/$ORG_NAME/$REPO_NAME/releases/latest/download"
ARTIFACT_NAME="installer-$OS-$ARCH"
DOWNLOAD_URL="$LATEST_URL/$ARTIFACT_NAME"

# Security Check: Ensure domain is github.com (INV-09)
echo "$DOWNLOAD_URL" | grep -q "^https://github.com" || error "Security violation: Invalid check domain"

log "Downloading from: $DOWNLOAD_URL"
curl -fsSL "$DOWNLOAD_URL" -o "$TEMP_DIR/$ARTIFACT_NAME" || error "Failed to download installer"
chmod +x "$TEMP_DIR/$ARTIFACT_NAME"

# -----------------------------------------------------------------------------
# PHASE 3: VERIFY INTEGRITY (INV-04)
# -----------------------------------------------------------------------------
log "Verifying integrity..."

CHECKSUMS_URL="$LATEST_URL/checksums.txt"
curl -fsSL "$CHECKSUMS_URL" -o "$TEMP_DIR/checksums.txt"

# Verify SHA256
cd "$TEMP_DIR"
grep "$ARTIFACT_NAME" checksums.txt | sha256sum -c - || error "Checksum verification failed!"
cd - > /dev/null

success "Integrity verified."

# -----------------------------------------------------------------------------
# PHASE 4: EXECUTE INSTALLER ENGINE
# -----------------------------------------------------------------------------
log "Launching installer engine..."

# Handover to the binary installer
"$TEMP_DIR/$ARTIFACT_NAME" --install-dir "$INSTALL_DIR"

# -----------------------------------------------------------------------------
# PHASE 5: CLEANUP & EXIT
# -----------------------------------------------------------------------------
# Cleanup handled by trap
