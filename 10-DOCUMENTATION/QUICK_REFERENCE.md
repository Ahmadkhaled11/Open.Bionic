# Open.Bionic Quick Reference

## 🚀 Installation

**Universal Installer (Recommended)**
```bash
# macOS / Linux
curl -fsSL https://github.com/Ahmadkhaled11/Open.Bionic/releases/latest/download/install.sh | sh

# Windows (PowerShell)
irm https://github.com/Ahmadkhaled11/Open.Bionic/releases/latest/download/install.ps1 | iex
```

---

## ⌨️ Shortcuts (Frontend)

| Key | Action |
|-----|--------|
| `Tab` | Focus next element |
| `Shift+Tab` | Focus previous element |
| `Enter` | Activate button |
| `Escape` | Clear text input |

---

## 🔧 CLI Tools (Backend)

| Command | Description |
|---------|-------------|
| `mix phx.server` | Start backend server |
| `mix test` | Run test suite |
| `mix deps.get` | Install dependencies |

---

## ❓ Troubleshooting

**"Failed to connect to backend"**
1. Ensure Docker is running OR you have Elixir installed.
2. Check if port `4000` is already in use.
3. Verify `http://localhost:4000/api/v1/health` returns JSON.

**"Installer permission denied"**
- **Unix:** Run `chmod +x install.sh`
- **Windows:** Run PowerShell as Administrator.

**"Build failed"**
- Check Node.js version (`node -v` should be >= 20)
- Check Elixir version (`elixir -v` should be >= 1.15)
