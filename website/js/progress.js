/**
 * ============================================================================
 * Progress Tracker
 * ----------------------------------------------------------------------------
 * Calculates and visualizes user progress across platform modules.
 * ============================================================================
 */

document.addEventListener('DOMContentLoaded', () => {
    const progressBar = document.getElementById('sidebarProgressBar');
    const progressLabel = document.querySelector('.progress-pct');

    function updateGlobalProgress() {
        if (!progressBar || !progressLabel) return;

        // In a full app, this would check an array of completed lesson IDs
        const completedLessons = window.StorageManager.get('completed_lessons', []);
        const totalPlatformLessons = 19; // Mock total derived from our JSON schema
        
        let percentage = 0;
        if (completedLessons.length > 0) {
            percentage = Math.round((completedLessons.length / totalPlatformLessons) * 100);
        } else {
            // Default active state for demonstration
            percentage = 12; 
        }

        // Animate the bar
        progressBar.style.width = `${percentage}%`;
        
        // Count up animation for the text
        let currentPct = 0;
        const interval = setInterval(() => {
            if (currentPct >= percentage) {
                clearInterval(interval);
                progressLabel.textContent = `${percentage}%`;
            } else {
                currentPct++;
                progressLabel.textContent = `${currentPct}%`;
            }
        }, 20);
    }

    // Run on load
    setTimeout(updateGlobalProgress, 500); // Slight delay for visual effect
});