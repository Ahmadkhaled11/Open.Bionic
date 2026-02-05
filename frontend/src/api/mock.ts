/**
 * Mock API for standalone frontend development
 * Used when Elixir backend is not available
 */

import { TransformResponse } from './client';

/**
 * Mock bionic text transformation (client-side)
 * Replicates the Elixir algorithm for development/demo
 */
export function mockBoldify(text: string): string {
    if (!text || typeof text !== 'string') return '';

    return text
        .trim()
        .split(/\s+/)
        .filter(word => word.length > 0)
        .map(boldifyWord)
        .join(' ');
}

function boldifyWord(word: string): string {
    if (word.length === 0) return word;

    const length = word.length;
    const half = Math.floor(length / 2);
    const splitAt = length % 2 === 0 ? half : half + 1;

    const boldPart = word.slice(0, splitAt);
    const rest = word.slice(splitAt);

    return `<b>${boldPart}</b>${rest}`;
}

/**
 * Mock transform response
 */
export function mockTransform(text: string): TransformResponse {
    const html = mockBoldify(text);
    const words = text.trim().split(/\s+/).filter(w => w.length > 0);

    return {
        success: true,
        data: {
            html,
            raw: text,
            stats: {
                word_count: words.length,
                char_count: text.length,
            },
        },
    };
}

/**
 * Mock RTF export (simplified)
 */
export function mockExportRTF(text: string): Blob {
    const bionic = mockBoldify(text);
    // Simple RTF with bold formatting
    const rtfContent = bionic
        .replace(/<b>/g, '{\\b ')
        .replace(/<\/b>/g, '}');

    const rtf = `{\\rtf1\\ansi\\deff0
{\\fonttbl{\\f0 Arial;}}
\\f0\\fs24
${rtfContent}
}`;

    return new Blob([rtf], { type: 'application/rtf' });
}

/**
 * Mock PDF export (HTML-based fallback)
 */
export function mockExportPDF(text: string): Blob {
    const bionic = mockBoldify(text);
    const html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Open.Bionic Export</title>
  <style>
    body { font-family: 'SF Pro Display', 'Segoe UI', sans-serif; font-size: 20px; line-height: 1.8; padding: 40px; max-width: 800px; margin: 0 auto; }
    b { font-weight: 700; }
  </style>
</head>
<body>
  ${bionic}
</body>
</html>`;

    // Return HTML as fallback (real PDF requires backend)
    return new Blob([html], { type: 'text/html' });
}
