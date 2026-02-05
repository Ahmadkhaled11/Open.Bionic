# Open.Bionic Elixir Library

> Universal RESTful API for Bionic Reading Accessibility

## Overview

The Open.Bionic library provides a RESTful API for transforming regular text into bionic reading format, helping ADHD readers improve focus and comprehension by bolding the first half of each word.

## Features

- ✅ **RESTful API** - Technology-agnostic HTTP endpoints
- ✅ **Real-time Processing** - Phoenix LiveView for instant transformations
- ✅ **Multiple Exports** - HTML, RTF, and PDF formats
- ✅ **High Performance** - < 50ms response time (p95)
- ✅ **CORS Enabled** - Cross-origin support for web integrations
- ✅ **Production Ready** - Comprehensive tests, error handling

## Installation

### Prerequisites

- Elixir 1.15+
- Erlang/OTP 26+
- PostgreSQL 15+

### Setup

```bash
# Install dependencies
mix deps.get

# Create database
mix ecto.create

# Run migrations
mix ecto.migrate

# Start Phoenix server
mix phx.server
```

Server will run at `http://localhost:4000`

## API Reference

### Health Check

```http
GET /api/v1/health
```

**Response:**
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "service": "Open.Bionic API"
}
```

---

### Transform Text (GET)

```http
GET /api/v1/transform/:text
```

**Example:**
```bash
curl http://localhost:4000/api/v1/transform/Hello%20World
```

**Response:**
```json
{
  "success": true,
  "data": {
    "html": "<b>Hel</b>lo <b>Wor</b>ld"
  }
}
```

---

### Transform Text (POST)

```http
POST /api/v1/transform
Content-Type: application/json
```

**Request Body:**
```json
{
  "text": "Hello World"
}
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

---

### Export as HTML

```http
POST /api/v1/export/html
Content-Type: application/json
```

**Request Body:**
```json
{
  "text": "Your text here"
}
```

**Response:** Full HTML document with styling

---

### Export as RTF

```http
POST /api/v1/export/rtf
Content-Type: application/json
```

**Request Body:**
```json
{
  "text": "Your text here"
}
```

**Response:** RTF file download (`openbionic.rtf`)

---

### Export as PDF

```http
POST /api/v1/export/pdf
Content-Type: application/json
```

**Request Body:**
```json
{
  "text": "Your text here"
}
```

**Response:** PDF file download (`openbionic.pdf`)

## Error Handling

All endpoints return consistent error format:

```json
{
  "success": false,
  "error": {
    "code": "INVALID_INPUT",
    "message": "Text cannot be empty"
  }
}
```

| Code | Status | Description |
|------|--------|-------------|
| `INVALID_INPUT` | 400 | Empty or invalid text |
| `TEXT_TOO_LONG` | 400 | Text exceeds 100,000 characters |
| `EXPORT_FAILED` | 500 | PDF/RTF generation failed |

## Testing

```bash
# Run all tests
mix test

# Run with coverage
mix test --cover

# Run specific test
mix test test/open_bionic/core/transformer_test.exs
```

## Module Documentation

### Core Modules

- **`OpenBionic.Core.Transformer`** - Bionic text transformation algorithm
- **`OpenBionic.Core.Validator`** - Input validation

### Export Modules

- **`OpenBionic.Export.HtmlGenerator`** - Styled HTML documents
- **`OpenBionic.Export.RtfGenerator`** - RTF format for Word
- **`OpenBionic.Export.PdfGenerator`** - PDF generation

### API Controllers

- **`OpenBionicWeb.Api.TransformController`** - Text transformation endpoints
- **`OpenBionicWeb.Api.ExportController`** - Export endpoints
- **`OpenBionicWeb.Api.HealthController`** - Health check

## Configuration

Edit `config/config.exs`:

```elixir
config :open_bionic,
  max_text_length: 100_000

config :cors_plug,
  origin: ["*"],
  methods: ["GET", "POST", "OPTIONS"]
```

## Deployment

See `fly.toml` for Fly.io deployment configuration.

```bash
# Deploy to Fly.io
fly deploy

# View logs
fly logs
```

## License

MIT License - See [LICENSE](../LICENSE)
