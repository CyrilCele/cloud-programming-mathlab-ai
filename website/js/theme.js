/**
 * ============================================================================
 * Theme Manager
 * ----------------------------------------------------------------------------
 * Handles Dark/Light mode switching and Local Storage persistence.
 * ============================================================================
 */

document.addEventListener("DOMContentLoaded", () => {
  const themeBtn = document.getElementById("themeSwitcher");
  const themeIcon = document.getElementById("themeIcon");
  const htmlEl = document.documentElement;

  // Initialize Theme
  const savedTheme = localStorage.getItem("mathlab-theme") || "dark";
  if (savedTheme === "light") {
    htmlEl.classList.add("light");
    themeIcon.textContent = "🌙";
  } else {
    htmlEl.classList.remove("light");
    themeIcon.textContent = "☀️";
  }

  // Toggle Logic
  themeBtn.addEventListener("click", () => {
    htmlEl.classList.toggle("light");
    const isLight = htmlEl.classList.contains("light");

    localStorage.setItem("mathlab-theme", isLight ? "light" : "dark");
    themeIcon.textContent = isLight ? "🌙" : "☀️";
  });
});
