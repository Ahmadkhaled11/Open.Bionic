# Open.Bionic Frontend

> Modern TypeScript Web Interface for Bionic Reading

## Overview

Beautiful, accessible web interface built with Vite and Vanilla TypeScript for transforming text into bionic reading format.

## Features

- ✅ **Live Preview** - Real-time bionic text transformation
- ✅ **Dark Mode** - Toggle between light and dark themes
- ✅ **Export Options** - Download as RTF or PDF files
- ✅ **Responsive Design** - Works on mobile, tablet, and desktop
- ✅ **Accessibility** - WCAG 2.1 AA compliant
- ✅ **Type Safety** - Full TypeScript support

## Installation

### Prerequisites

- Node.js 20+ (LTS recommended)

### Setup

```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

Application will run at `http://localhost:3000`

## Development

```bash
# Type checking
npm run type-check

# Build for production
npm run build

# Preview production build
npm run preview

# Run tests
npm run test

# E2E tests
npm run test:e2e
```

## Project Structure

```
frontend/
├── public/
│   └── Open_bionic_small.png
├── src/
│   ├── api/
│   │   └── client.ts           # API client
│   ├── components/
│   │   ├── TextInput.ts        # Text input component
│   │   ├── PreviewPanel.ts     # Preview display
│   │   ├── ExportButtons.ts    # RTF/PDF export
│   │   └── ThemeToggle.ts      # Dark mode toggle
│   ├── styles/
│   │   ├── reset.css           # CSS reset
│   │   ├── tokens.css          # Design tokens
│   │   └── main.css            # Main styles
│   ├── utils/
│   │   ├── debounce.ts         # Utility functions
│   │   └── download.ts
│   └── main.ts                 # Application entry
├── index.html
├── package.json
├── tsconfig.json
└── vite.config.ts
```

## Components Documentation

### TextInput

Text input area with debounced transformations (300ms) and character counter.

```typescript
const textInput = new TextInput((text) => {
  // Handle text change
});
```

### PreviewPanel

Displays transformed bionic text with loading states.

```typescript
const preview = new PreviewPanel();
preview.showLoading();
preview.setContent('<b>Hel</b>lo <b>Wor</b>ld');
preview.hideLoading();
```

### ExportButtons

RTF and PDF export functionality.

```typescript
const exportButtons = new ExportButtons(client, () => getText());
```

### ThemeToggle

Dark/light mode toggle with localStorage persistence.

```typescript
const themeToggle = new ThemeToggle();
```

## API Integration

The frontend communicates with the Elixir backend via the `OpenBionicClient`:

```typescript
import { OpenBionicClient } from './api/client';

const client = new OpenBionicClient('/api/v1');

// Transform text
const response = await client.transform({ text: 'Hello World' });

// Export PDF
const pdfBlob = await client.exportPDF('Hello World');

// Export RTF
const rtfBlob = await client.exportRTF('Hello World');
```

## Environment Configuration

The Vite dev server proxies API calls to the backend:

```typescript
// vite.config.ts
proxy: {
  '/api': {
    target: 'http://localhost:4000',
    changeOrigin: true,
  },
}
```

## Design System

### Color Tokens

```css
--accent: #6366F1;        /* Primary actions */
--text-primary: #1A1A1A;  /* Main text */
--bg-secondary: #FFFFFF;   /* Cards/panels */
```

### Typography

```css
--font-sans: 'Inter', ...       /* UI text */
--font-bionic: 'SF Pro Display' /* Bionic output */
```

## Accessibility

- ✅ Keyboard navigation support
- ✅ ARIA labels on all interactive elements
- ✅ Focus indicators
- ✅ Screen reader compatible
- ✅ Respects `prefers-reduced-motion`
- ✅ Color contrast WCAG AA compliant

## Browser Support

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Android)

## License

MIT License - See [LICENSE](../LICENSE)
