/**
 * ============================================================================
 * Global Configuration
 * ----------------------------------------------------------------------------
 * Manages API endpoints, MathJax rendering rules, and global states.
 * ============================================================================
 */

// MathJax 3 Configuration (Extracted from the XML template)
window.MathJax = {
  tex: {
    inlineMath: [
      ["$", "$"],
      ["\\(", "\\)"],
    ],
    displayMath: [
      ["$$", "$$"],
      ["\\[", "\\]"],
    ],
    processEscapes: true,
    packages: { "[+]": ["base", "ams", "noerrors", "noundefined"] },
  },
  options: {
    ignoreHtmlClass: "tex2jax_ignore",
    processHtmlClass: "tex2jax_process",
  },
  loader: {
    load: ["[tex]/ams"],
  },
};

// Application Config
window.AppConfig = {
  version: "1.0.0",
  paths: {
    lessonsData: "assets/data/lessons.json", // Where app.js will fetch content
  },
};
