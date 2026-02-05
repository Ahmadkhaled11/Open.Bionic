# Open.Bionic Universal Installer Implementation (State Machine)

> **Pseudocode Implementation Spec**
> Language: Go/Python-like Pseudocode
> Enforces: INV-01, INV-02, INV-03, INV-04, INV-05, INV-06, INV-07

---

## State Machine Definitions

```go
type State string

const (
    BOOTSTRAP          State = "BOOTSTRAP"
    DETECT_ENV         State = "DETECT_ENV"
    FETCH_ARTIFACT     State = "FETCH_ARTIFACT"
    VERIFY_INTEGRITY   State = "VERIFY_INTEGRITY"
    INSTALL_OR_UPGRADE State = "INSTALL_OR_UPGRADE"
    VALIDATE           State = "VALIDATE"
    DIAGNOSE           State = "DIAGNOSE"
    HEAL               State = "HEAL"
    FINALIZE           State = "FINALIZE"
    LAUNCH             State = "LAUNCH"
    GUIDE_USER         State = "GUIDE_USER"
)

type InstallerState struct {
    CurrentState State
    InstallPath  string
    Version      string
    RetryCount   int
    Health       HealthStatus
}
```

---

## Core Logic Flow

```python
def main():
    state = load_state() or initialize_state()
    
    while state.current_state != "EXIT":
        try:
            if state.current_state == BOOTSTRAP:
                run_bootstrapper()
                transition_to(DETECT_ENV)

            elif state.current_state == DETECT_ENV:
                env = detect_environment()
                if not env.supported:
                    abort("Unsupported environment")
                transition_to(FETCH_ARTIFACT)

            elif state.current_state == FETCH_ARTIFACT:
                # INV-08/09: GitHub Releases ONLY
                url = f"https://github.com/{ORG}/{REPO}/releases/download/{VERSION}/installer-{OS}-{ARCH}"
                artifact = download_secure(url)
                transition_to(VERIFY_INTEGRITY)

            elif state.current_state == VERIFY_INTEGRITY:
                # INV-04: Integrity Verification
                if not verify_signature(artifact) or not verify_checksum(artifact):
                    abort("Integrity check failed")
                transition_to(INSTALL_OR_UPGRADE)

            elif state.current_state == INSTALL_OR_UPGRADE:
                # INV-01: Idempotency
                # INV-03: Data Safety
                backup_user_data()
                atomic_install(artifact)
                transition_to(VALIDATE)

            elif state.current_state == VALIDATE:
                # INV-06: Validation Gate
                if not run_trace_smoke_test():
                    transition_to(DIAGNOSE) # Failover to heal
                else:
                    transition_to(DIAGNOSE) # Always diagnose (INV-07)

            elif state.current_state == DIAGNOSE:
                # INV-07: Diagnostics
                issues = run_full_diagnostics()
                if issues:
                    transition_to(HEAL)
                else:
                    transition_to(FINALIZE)

            elif state.current_state == HEAL:
                # Self-healing loop
                if attempt_repair(issues):
                    transition_to(VALIDATE) # Verify fix
                else:
                    abort("Auto-repair failed, manual intervention needed")

            elif state.current_state == FINALIZE:
                # INV-02: Clean State
                persist_success_state()
                cleanup_temp_files()
                transition_to(LAUNCH)

            elif state.current_state == LAUNCH:
                exec(BINARY_PATH)
                transition_to(GUIDE_USER)

            elif state.current_state == GUIDE_USER:
                show_interactive_menu()
                exit(0)

        except Exception as e:
            handle_fatal_error(e)
```

---

## Key Functions & Invariants

### `download_secure(url)`
- **Constraint**: Must match regex `^https://github\.com/[^/]+/[^/]+/releases/download/.*$`
- **Constraint**: No redirects to non-GitHub domains.

### `atomic_install(artifact)`
- **Constraint**: Uses temp directory + rename (atomic swap).
- **Constraint**: Never deletes `config/` or `data/` directories.

### `attempt_repair(issues)`
- **Logic**:
    - Missing binary -> Re-download
    - Corrupt config -> Restore backup or usage default
    - Permission error -> Suggest `sudo` (if allowed) or change path
- **Retries**: Max 3 attempts before failure.
