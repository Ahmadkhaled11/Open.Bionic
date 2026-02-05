import './styles/reset.css';
import './styles/tokens.css';
import './styles/main.css';

import { OpenBionicClient } from './api/client';
import { TextInput } from './components/TextInput';
import { PreviewPanel } from './components/PreviewPanel';
import { ExportButtons } from './components/ExportButtons';
import { ThemeToggle } from './components/ThemeToggle';

class App {
    private client: OpenBionicClient;
    private textInput: TextInput;
    private previewPanel: PreviewPanel;
    private exportButtons: ExportButtons;
    private themeToggle: ThemeToggle;

    constructor() {
        this.client = new OpenBionicClient();
        this.previewPanel = new PreviewPanel();
        this.textInput = new TextInput(this.handleTextChange.bind(this));
        this.exportButtons = new ExportButtons(this.client, () => this.textInput.getValue());
        this.themeToggle = new ThemeToggle();

        this.init();
    }

    private async handleTextChange(text: string): Promise<void> {
        if (!text.trim()) {
            this.previewPanel.clear();
            return;
        }

        try {
            this.previewPanel.showLoading();
            const response = await this.client.transform({ text });

            if (response.success && response.data) {
                this.previewPanel.setContent(response.data.html);
            } else if (response.error) {
                this.previewPanel.showError(response.error.message);
            }
        } catch (error) {
            console.error('Transformation failed:', error);
            this.previewPanel.showError('Failed to transform text. Please check if the backend is running.');
        } finally {
            this.previewPanel.hideLoading();
        }
    }

    private init(): void {
        const app = document.getElementById('app');
        if (!app) return;

        // Header
        const header = document.createElement('header');
        header.className = 'app-header';
        header.innerHTML = '<h1>Open<span class="separator">|</span>Bionic</h1>';

        const headerActions = document.createElement('div');
        headerActions.className = 'header-actions';
        this.themeToggle.render(headerActions);
        header.appendChild(headerActions);

        // Main content
        const main = document.createElement('main');
        main.className = 'app-main';

        const inputSection = document.createElement('section');
        inputSection.className = 'input-section';
        this.textInput.render(inputSection);

        const previewSection = document.createElement('section');
        previewSection.className = 'preview-section';
        this.previewPanel.render(previewSection);

        const actionsSection = document.createElement('section');
        actionsSection.className = 'actions-section';
        this.exportButtons.render(actionsSection);

        main.appendChild(inputSection);
        main.appendChild(previewSection);
        main.appendChild(actionsSection);

        // Footer
        const footer = document.createElement('footer');
        footer.className = 'app-footer';
        footer.innerHTML = '<p>Open.Bionic - Accessibility Reading System for ADHD</p>';

        app.appendChild(header);
        app.appendChild(main);
        app.appendChild(footer);

        // Set default text
        this.textInput.setValue('Hello World! This is bionic reading.');
        this.handleTextChange('Hello World! This is bionic reading.');
    }
}

// Initialize app
new App();
