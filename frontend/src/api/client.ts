/**
 * Type definitions for Open.Bionic API
 */

import { mockTransform, mockExportRTF, mockExportPDF } from './mock';

export interface TransformRequest {
    text: string;
    options?: {
        intensity?: number;
        format?: 'html';
    };
}

export interface TransformResponse {
    success: boolean;
    data?: {
        html: string;
        raw: string;
        stats: {
            word_count: number;
            char_count: number;
        };
    };
    error?: {
        code: string;
        message: string;
    };
}

export class OpenBionicClient {
    private baseURL: string;
    private useMock: boolean = false;

    constructor(baseURL: string = '/api/v1') {
        this.baseURL = baseURL;
    }

    /**
     * Transform text to bionic reading format
     */
    async transform(request: TransformRequest): Promise<TransformResponse> {
        try {
            const response = await fetch(`${this.baseURL}/transform`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(request),
            });

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            this.useMock = false;
            return response.json();
        } catch (error) {
            // Fallback to mock mode if backend unavailable
            console.warn('Backend unavailable, using mock mode:', error);
            this.useMock = true;
            return mockTransform(request.text);
        }
    }

    /**
     * Export text as PDF
     */
    async exportPDF(text: string): Promise<Blob> {
        if (this.useMock) {
            return mockExportPDF(text);
        }

        try {
            const response = await fetch(`${this.baseURL}/export/pdf`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ text }),
            });

            if (!response.ok) {
                throw new Error(`PDF export failed: ${response.statusText}`);
            }

            return response.blob();
        } catch (error) {
            console.warn('PDF export failed, using mock:', error);
            return mockExportPDF(text);
        }
    }

    /**
     * Export text as RTF
     */
    async exportRTF(text: string): Promise<Blob> {
        if (this.useMock) {
            return mockExportRTF(text);
        }

        try {
            const response = await fetch(`${this.baseURL}/export/rtf`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ text }),
            });

            if (!response.ok) {
                throw new Error(`RTF export failed: ${response.statusText}`);
            }

            return response.blob();
        } catch (error) {
            console.warn('RTF export failed, using mock:', error);
            return mockExportRTF(text);
        }
    }

    /**
     * Check API health
     */
    async health(): Promise<{ status: string; version: string }> {
        try {
            const response = await fetch(`${this.baseURL}/health`);
            return response.json();
        } catch (error) {
            return { status: 'mock', version: '1.0.0-mock' };
        }
    }
}
