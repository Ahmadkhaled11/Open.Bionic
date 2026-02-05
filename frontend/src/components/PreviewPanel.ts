export class PreviewPanel {
    private element: HTMLDivElement;
    private loadingSpinner: HTMLElement;
    private output: HTMLElement;

    constructor() {
        this.element = document.createElement('div');
        this.element.className = 'preview-panel';

        this.loadingSpinner = this.createLoadingSpinner();
        this.output = this.createOutput();

        this.element.appendChild(this.loadingSpinner);
        this.element.appendChild(this.output);
    }

    private createLoadingSpinner(): HTMLElement {
        const spinner = document.createElement('div');
        spinner.className = 'loading-spinner hidden';
        spinner.innerHTML = '<div class="spinner"></div>';
        return spinner;
    }

    private createOutput(): HTMLElement {
        const output = document.createElement('div');
        output.className = 'bionic-output';
        output.setAttribute('data-testid', 'preview');
        return output;
    }

    showLoading(): void {
        this.loadingSpinner.classList.remove('hidden');
        this.output.classList.add('faded');
    }

    hideLoading(): void {
        this.loadingSpinner.classList.add('hidden');
        this.output.classList.remove('faded');
    }

    setContent(html: string): void {
        this.output.innerHTML = html;
    }

    clear(): void {
        this.output.innerHTML = '<p class="placeholder">Your bionic text will appear here...</p>';
    }

    showError(message: string): void {
        this.output.innerHTML = `<p class="error">${message}</p>`;
    }

    render(parent: HTMLElement): void {
        parent.appendChild(this.element);
    }
}
