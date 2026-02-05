export class ThemeToggle {
    private button: HTMLButtonElement;
    private currentTheme: 'light' | 'dark';

    constructor() {
        this.currentTheme = this.getPreferredTheme();
        this.button = this.createButton();
        this.applyTheme(this.currentTheme);
    }

    private getPreferredTheme(): 'light' | 'dark' {
        const stored = localStorage.getItem('theme');
        if (stored === 'light' || stored === 'dark') {
            return stored;
        }
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    }

    private createButton(): HTMLButtonElement {
        const button = document.createElement('button');
        button.className = 'theme-toggle';
        button.setAttribute('aria-label', 'Toggle dark mode');
        button.setAttribute('aria-pressed', this.currentTheme === 'dark' ? 'true' : 'false');
        button.innerHTML = this.currentTheme === 'dark' ? '☀️' : '🌙';

        button.addEventListener('click', () => this.toggle());

        return button;
    }

    private toggle(): void {
        this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light';
        this.applyTheme(this.currentTheme);
        localStorage.setItem('theme', this.currentTheme);
    }

    private applyTheme(theme: 'light' | 'dark'): void {
        document.documentElement.setAttribute('data-theme', theme);
        this.button.innerHTML = theme === 'dark' ? '☀️' : '🌙';
        this.button.setAttribute('aria-pressed', theme === 'dark' ? 'true' : 'false');
    }

    render(parent: HTMLElement): void {
        parent.appendChild(this.button);
    }
}
