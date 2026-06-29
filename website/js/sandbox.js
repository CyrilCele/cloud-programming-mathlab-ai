/**
 * ============================================================================
 * Math Sandbox Manager
 * ----------------------------------------------------------------------------
 * Handles real-time LaTeX rendering using MathJax 3.
 * ============================================================================
 */

document.addEventListener("DOMContentLoaded", () => {
  const heroSandboxBtn = document.getElementById("openSandboxHero");
  const dynamicContentArea = document.getElementById("dynamicContentArea");

  // Create Sandbox Drawer DOM dynamically if requested
  function createSandboxDrawer() {
    if (document.getElementById("mathSandboxDrawer")) return;

    const drawer = document.createElement("div");
    drawer.id = "mathSandboxDrawer";
    drawer.className = "sandbox-drawer";
    drawer.innerHTML = `
            <div class="sandbox-header">
                <div class="sandbox-title">
                    <svg fill="none" height="18" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                    LaTeX Sandbox
                </div>
                <button class="sandbox-close" id="closeSandboxBtn" aria-label="Close Sandbox">&times;</button>
            </div>
            <div class="sandbox-body">
                <div class="sandbox-input-area">
                    <label for="sandboxInput">Input (LaTeX)</label>
                    <textarea id="sandboxInput" placeholder="Type your equation here... e.g., \\int_{0}^{\\infty} x^2 e^{-x} dx"></textarea>
                </div>
                <div class="sandbox-preview-area">
                    <span class="sandbox-preview-label">Live Preview</span>
                    <div class="sandbox-render-target" id="sandboxPreview"></div>
                </div>
            </div>
        `;

    document.body.appendChild(drawer);
    initSandboxEvents();
  }

  function initSandboxEvents() {
    const input = document.getElementById("sandboxInput");
    const preview = document.getElementById("sandboxPreview");
    const closeBtn = document.getElementById("closeSandboxBtn");
    const drawer = document.getElementById("mathSandboxDrawer");

    // Load saved formula
    const savedFormula = window.StorageManager.get("sandbox_draft", "");
    if (savedFormula) {
      input.value = savedFormula;
      renderMath(savedFormula, preview);
    }

    // Live Rendering with Debounce
    const handleInput = window.Utils.debounce((e) => {
      const rawTex = e.target.value;
      window.StorageManager.set("sandbox_draft", rawTex);
      renderMath(rawTex, preview);
    }, 400);

    input.addEventListener("input", handleInput);

    closeBtn.addEventListener("click", () => {
      drawer.classList.remove("open");
    });
  }

  function renderMath(tex, targetNode) {
    if (!window.MathJax) return;

    // Wrap in display math format if not already wrapped
    let formattedTex = tex;
    if (!tex.includes("$") && !tex.includes("\\[")) {
      formattedTex = `$$${tex}$$`;
    }

    targetNode.innerHTML = formattedTex;
    MathJax.typesetPromise([targetNode]).catch((err) =>
      console.error("MathJax error:", err),
    );
  }

  // Event Listener for opening sandbox
  if (heroSandboxBtn) {
    heroSandboxBtn.addEventListener("click", () => {
      createSandboxDrawer();
      // Allow DOM to update before adding 'open' class for transition
      requestAnimationFrame(() => {
        document.getElementById("mathSandboxDrawer").classList.add("open");
      });
    });
  }
});
