/**
 * ============================================================================
 * Utility Functions
 * ----------------------------------------------------------------------------
 * Shared helpers for DOM manipulation, debouncing, and formatting.
 * ============================================================================
 */

const Utils = {
  /**
   * Debounce function to limit the rate at which a function fires.
   * Ideal for search inputs and window resizing.
   */
  debounce: (func, wait = 300) => {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  },

  /**
   * Safely creates a DOM element with classes and attributes.
   */
  createElement: (tag, classNames = "", attributes = {}) => {
    const el = document.createElement(tag);
    if (classNames) el.className = classNames;
    for (const [key, value] of Object.entries(attributes)) {
      el.setAttribute(key, value);
    }
    return el;
  },

  /**
   * Escapes HTML to prevent XSS attacks when rendering dynamic content.
   */
  escapeHTML: (str) => {
    const div = document.createElement("div");
    div.textContent = str;
    return div.innerHTML;
  },
};

window.Utils = Utils;
