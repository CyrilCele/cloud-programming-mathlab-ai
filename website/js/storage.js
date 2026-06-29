/**
 * ============================================================================
 * Local Storage Manager
 * ----------------------------------------------------------------------------
 * Safe wrapper for browser localStorage with error handling.
 * ============================================================================
 */

const StorageManager = {
  prefix: "mathlab_ai_",

  set: (key, value) => {
    try {
      const serializedValue = JSON.stringify(value);
      localStorage.setItem(StorageManager.prefix + key, serializedValue);
      return true;
    } catch (e) {
      console.error("StorageManager Error saving data", e);
      return false;
    }
  },

  get: (key, defaultValue = null) => {
    try {
      const item = localStorage.getItem(StorageManager.prefix + key);
      return item ? JSON.parse(item) : defaultValue;
    } catch (e) {
      console.error("StorageManager Error reading data", e);
      return defaultValue;
    }
  },

  remove: (key) => {
    localStorage.removeItem(StorageManager.prefix + key);
  },

  clearAll: () => {
    Object.keys(localStorage).forEach((key) => {
      if (key.startsWith(StorageManager.prefix)) {
        localStorage.removeItem(key);
      }
    });
  },
};

window.StorageManager = StorageManager;
