import { OpenBionicClient } from '../api/client';
import { downloadBlob } from '../utils/download';

export class ExportButtons {
    private rtfButton: HTMLButtonElement;
    private pdfButton: HTMLButtonElement;
    private client: OpenBionicClient;
    private getText: () => string;

    constructor(client: OpenBionicClient, getText: () => string) {
        this.client = client;
        this.getText = getText;
        this.rtfButton = this.createButton('RTF', '📥', this.handleRTFExport.bind(this));
        this.pdfButton = this.createButton('PDF', '📥', this.handlePDFExport.bind(this));
    }

    private createButton(label: string, icon: string, handler: () => void): HTMLButtonElement {
        const button = document.createElement('button');
        button.className = 'export-button';
        button.innerHTML = `${icon} ${label}`;
        button.setAttribute('aria-label', `Download as ${label} file`);
        button.addEventListener('click', handler);
        return button;
    }

    private async handleRTFExport(): Promise<void> {
        const text = this.getText();
        if (!text.trim()) {
            alert('Please enter some text first');
            return;
        }

        try {
            this.setButtonLoading(this.rtfButton, true);
            const blob = await this.client.exportRTF(text);
            downloadBlob(blob, 'openbionic.rtf');
        } catch (error) {
            console.error('RTF export failed:', error);
            alert('Failed to export RTF. Please try again.');
        } finally {
            this.setButtonLoading(this.rtfButton, false);
        }
    }

    private async handlePDFExport(): Promise<void> {
        const text = this.getText();
        if (!text.trim()) {
            alert('Please enter some text first');
            return;
        }

        try {
            this.setButtonLoading(this.pdfButton, true);
            const blob = await this.client.exportPDF(text);
            downloadBlob(blob, 'openbionic.pdf');
        } catch (error) {
            console.error('PDF export failed:', error);
            alert('Failed to export PDF. Please try again.');
        } finally {
            this.setButtonLoading(this.pdfButton, false);
        }
    }

    private setButtonLoading(button: HTMLButtonElement, isLoading: boolean): void {
        button.disabled = isLoading;
        if (isLoading) {
            button.classList.add('loading');
        } else {
            button.classList.remove('loading');
        }
    }

    render(parent: HTMLElement): void {
        const container = document.createElement('div');
        container.className = 'export-buttons';
        container.appendChild(this.rtfButton);
        container.appendChild(this.pdfButton);
        parent.appendChild(container);
    }
}
