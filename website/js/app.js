/**
 * ============================================================================
 * App Engine
 * ----------------------------------------------------------------------------
 * Fetches JSON data and dynamically renders the UI.
 * ============================================================================
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log(`MathLab AI v${window.AppConfig.version} Initialized.`);
    
    const pathsContainer = document.getElementById('pathsGridContainer');

    /**
     * Fetches the platform data
     */
    async function loadPlatformData() {
        try {
            // In a real AWS S3/CloudFront setup, this path resolves to your bucket
            const response = await fetch(window.AppConfig.paths.lessonsData);
            if (!response.ok) throw new Error('Network response was not ok');
            
            const data = await response.json();
            renderLearningPaths(data.learningPaths);
        } catch (error) {
            console.error('Failed to load platform data:', error);
            pathsContainer.innerHTML = `<div class="error-state">Failed to load learning paths. Please check your connection.</div>`;
        }
    }

    /**
     * Renders the path cards dynamically
     */
    function renderLearningPaths(paths) {
        if (!pathsContainer) return;
        pathsContainer.innerHTML = ''; // Clear placeholder

        paths.forEach((path, index) => {
            const article = document.createElement('article');
            article.className = `path-card animate-fade-in-up stagger-${(index % 4) + 1}`;
            article.setAttribute('role', 'link');
            article.tabIndex = 0; // Accessibility: focusable
            
            // Allow click anywhere on the card to navigate
            article.addEventListener('click', () => window.location.href = path.url);
            article.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') window.location.href = path.url;
            });

            article.innerHTML = `
                <span class="path-difficulty ${path.difficultyClass}">${Utils.escapeHTML(path.difficulty)}</span>
                <div class="path-meta">
                    <span class="path-badge">${Utils.escapeHTML(path.badge)}</span>
                    <h3 class="path-title">${Utils.escapeHTML(path.title)}</h3>
                    <p class="path-desc">${Utils.escapeHTML(path.description)}</p>
                </div>
                <div class="path-footer">
                    <span class="path-stat">${Utils.escapeHTML(path.lessonCount)}</span>
                    <button class="path-btn" aria-label="Go to ${Utils.escapeHTML(path.title)}">→</button>
                </div>
            `;
            
            pathsContainer.appendChild(article);
        });
    }

    // Initialize the data fetch
    loadPlatformData();
});