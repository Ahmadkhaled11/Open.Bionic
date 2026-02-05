import { debounce } from '../utils/debounce';

export class TextInput {
    private element: HTMLTextAreaElement;
    private charCounter: HTMLElement;
    private onTextChange: (text: string) => void;

    constructor(onTextChange: (text: string) => void) {
        this.onTextChange = debounce(onTextChange, 300);
        this.element = this.createTextArea();
        this.charCounter = this.createCharCounter();
    }

    private createTextArea(): HTMLTextAreaElement {
        const textarea = document.createElement('textarea');
        textarea.className = 'text-input';
        textarea.placeholder = 'Enter or paste your text here...';
        textarea.setAttribute('aria-label', 'Enter text to transform into bionic reading format');
        textarea.rows = 8;
        textarea.maxLength = 100000; // Enforce MAX_LENGTH invariant

        textarea.addEventListener('input', (e) => {
            const text = (e.target as HTMLTextAreaElement).value;
            this.updateCharCounter(text);
            this.onTextChange(text);
        });

        return textarea;

    }

    private createCharCounter(): HTMLElement {
        const counter = document.createElement('div');
        counter.className = 'char-counter';
        counter.textContent = '0 characters';
        return counter;
    }

    private updateCharCounter(text: string): void {
        const count = text.length;
        this.charCounter.textContent = `${count.toLocaleString()} character${count !== 1 ? 's' : ''}`;
    }

    render(parent: HTMLElement): void {
        const container = document.createElement('div');
        container.className = 'text-input-container';
        container.appendChild(this.element);
        container.appendChild(this.charCounter);
        parent.appendChild(container);
    }

    getValue(): string {
        return this.element.value;
    }

    setValue(text: string): void {
        this.element.value = text;
        this.updateCharCounter(text);
    }
}
