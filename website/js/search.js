/**
 * ============================================================================
 * Global Search
 * ----------------------------------------------------------------------------
 * Handles real-time filtering of lessons and paths across the platform.
 * ============================================================================
 */

document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.getElementById("lessonSearch");
  if (!searchInput) return;

  const handleSearch = window.Utils.debounce((e) => {
    const query = e.target.value.toLowerCase().trim();
    const pathCards = document.querySelectorAll(".path-card");

    pathCards.forEach((card) => {
      const title = card.querySelector(".path-title").textContent.toLowerCase();
      const desc = card.querySelector(".path-desc").textContent.toLowerCase();

      if (title.includes(query) || desc.includes(query)) {
        card.style.display = "flex";
        card.style.animation = "fadeIn 0.3s ease forwards";
      } else {
        card.style.display = "none";
      }
    });
  }, 300);

  searchInput.addEventListener("input", handleSearch);
});
