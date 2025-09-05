import { Controller } from "@hotwired/stimulus"

document.addEventListener("turbo:load", () => {
  const toggleButton = document.getElementById("toggle-theme");
  if (!toggleButton) return;

  if (localStorage.getItem("chatLightMode") === "true") {
    document.body.classList.add("light-mode");
    toggleButton.textContent = "💡";
  } else {
    document.body.classList.remove("light-mode");
    toggleButton.textContent = "💡";
  }

  toggleButton.onclick = () => {
    document.body.classList.toggle("light-mode");
    const isLight = document.body.classList.contains("light-mode");
    localStorage.setItem("chatLightMode", isLight);
    toggleButton.textContent = isLight ? "💡" : "💡";
  };
});
