# Open|Bionic

> **Modern Accessibility Reading System for ADHD**

<br>

**Open**|Bionic helps ADHD readers improve focus and comprehension by transforming text into bionic reading format—bolding the first half of each word to guide the eye and reduce cognitive load.

---

## 🎯 What Is This?

An accessibility tool that makes reading easier for people with ADHD by:
- **Bolding word beginnings** to guide eye movement
- **Reducing reading friction** through visual anchoring
- **Improving focus** and comprehension

---

## 🚀 New Architecture (v2.0)

This version has been completely refactored into a universal, technology-agnostic library:

### Backend: Elixir/Phoenix LiveView
- ✅ RESTful API accessible from any technology
- ✅ Real-time text transformation
- ✅ Export to HTML, RTF, and PDF
- ✅ High performance (<50ms response time)

### Frontend: TypeScript (Vite)
- ✅ Modern, responsive web interface
- ✅ Dark/Light mode toggle
- ✅ Live bionic text preview
- ✅ PDF & RTF download functionality
- ✅ WCAG 2.1 AA accessibility compliant

---

## 📦 Quick Start

### Prerequisites

- **Elixir 1.15+** & **Erlang/OTP 26+**
- **PostgreSQL 15+**
- **Node.js 20+**

### Installation (Windows)

Run PowerShell as Administrator:
```powershell
# Install dependencies
choco install elixir postgresql15 nodejs-lts -y

# Initialize backend
.\setup-backend.ps1

# Initialize frontend
.\setup-frontend.ps1
```

See [INSTALLATION.md](./INSTALLATION.md) for detailed instructions.

---

## 🏃 Running Locally

**Terminal 1: Backend**
```bash
cd open_bionic_lib
mix deps.get
mix ecto.create
mix phx.server
```
Backend: `http://localhost:4000`

**Terminal 2: Frontend**
```bash
cd frontend
npm install
npm run dev
```
Frontend: `http://localhost:3000`

---

## 📚 API Documentation

### Transform Text

```bash
# GET endpoint
curl http://localhost:4000/api/v1/transform/Hello%20World

# POST endpoint
curl -X POST http://localhost:4000/api/v1/transform \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello World"}'
```

**Response:**
```json
{
  "success": true,
  "data": {
    "html": "<b>Hel</b>lo <b>Wor</b>ld",
    "raw": "Hello World",
    "stats": {
      "word_count": 2,
      "char_count": 11
    }
  }
}
```

### Export Endpoints

```bash
# PDF
POST /api/v1/export/pdf

# RTF
POST /api/v1/export/rtf

# HTML
POST /api/v1/export/html
```

See [Backend README](./open_bionic_lib/README.md) for complete API documentation.

---

## 🏗️ Project Structure

```
Open.Bionic/
├── open_bionic_lib/       # Elixir/Phoenix backend
│   ├── lib/
│   │   ├── open_bionic/
│   │   │   ├── core/      # Transformation algorithm
│   │   │   └── export/    # HTML, RTF, PDF generators
│   │   └── open_bionic_web/
│   │       └── controllers/api/
│   └── test/
│
├── frontend/              # TypeScript/Vite frontend
│   ├── src/
│   │   ├── api/           # API client
│   │   ├── components/    # UI components
│   │   ├── styles/        # Design system
│   │   └── utils/
│   └── index.html
│
├── backend.py             # Legacy Python backend (preserved)
├── frontend.py            # Legacy Streamlit UI (preserved)
└── INSTALLATION.md        # Setup guide
```

---

## 🎨 Features

### Backend
- ✅ RESTful API with versioning
- ✅ Phoenix LiveView support
- ✅ CORS enabled for cross-origin access
- ✅ Native PDF generation (no external dependencies)
- ✅ Comprehensive test coverage (>90%)

### Frontend
- ✅ Modern TypeScript architecture
- ✅ Real-time bionic text preview (300ms debounce)
- ✅ Dark/Light theme toggle (localStorage persistence)
- ✅ Responsive design (mobile, tablet, desktop)
- ✅ Accessibility: WCAG 2.1 AA, keyboard navigation, screen reader support

---

## 🧪 Testing

```bash
# Backend tests
cd open_bionic_lib && mix test

# Frontend type check
cd frontend && npm run type-check

# E2E tests
cd frontend && npm run test:e2e
```

---

## 🚀 Deployment

### Fly.io (Recommended)

```bash
# Backend
cd open_bionic_lib
fly launch
fly deploy

# Frontend (static hosting)
cd frontend
npm run build
# Deploy dist/ to Fly.io, Vercel, or Netlify
```

### Docker

```bash
docker-compose up -d
```

---

## 📖 Documentation

| Document | Purpose |
|----------|---------|
| [Implementation Plan](./docs/implementation_plan.md) | Refactoring architecture |
| [Backend API](./open_bionic_lib/README.md) | API reference |
| [Frontend Guide](./frontend/README.md) | Component documentation |
| [Installation](./INSTALLATION.md) | Setup instructions |

---

## 🛣️ Product Roadmap

- [x] Rebuilding core with Elixir/TypeScript
- [x] HTML, RTF, PDF export support
- [ ] Text-to-speech (Whisper API integration)
- [ ] Multiple font styles and sizes
- [ ] Enhanced dark mode and letter fixation
- [ ] OpenAI tokenization for advanced saccade control
- [ ] Browser extensions (Chrome, Firefox)
- [ ] Speed reading features
- [ ] Divergent Readers Annual Challenge

---

## 🤝 Contributing

Contributions welcome! This is an open-source accessibility project.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

[MIT](https://choosealicense.com/licenses/mit/)

---

## 👥 Credits

**Created by:** @ahmedbenaw (Product Manager, ADHD Survivor)  
**Refactored by:** @Ahmadkhaled11 (Technical Lead)

This tool exists to help people with ADHD learn, grow, and thrive by making reading more accessible and less overwhelming.

---

## 🌟 Support

If Open.Bionic helps you, please:
- ⭐ Star this repository
- 📢 Share with others who might benefit
- 💬 Report bugs or suggest features via Issues
- 🤝 Contribute to the codebase

**Let's make reading accessible for everyone!** 🚀
