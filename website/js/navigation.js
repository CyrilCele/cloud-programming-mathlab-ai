/**
 * ============================================================================
 * Navigation Manager
 * ----------------------------------------------------------------------------
 * Handles mobile hamburger menu toggling and click-away closing.
 * ============================================================================
 */

document.addEventListener("DOMContentLoaded", () => {
  const mobileNavBtn = document.getElementById("mobileNavBtn");
  const sidebar = document.getElementById("sidebarLeft");

  // Toggle Sidebar
  mobileNavBtn.addEventListener("click", (e) => {
    e.stopPropagation();
    sidebar.classList.toggle("open");
  });

  // Close Sidebar when clicking outside on mobile
  document.addEventListener("click", (e) => {
    if (window.innerWidth <= 1024) {
      if (!sidebar.contains(e.target) && sidebar.classList.contains("open")) {
        sidebar.classList.remove("open");
      }
    }
  });
});
