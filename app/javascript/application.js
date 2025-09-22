// app/javascript/application.js

// Importa Rails Turbo y otras configuraciones
import "@hotwired/turbo-rails"
import "controllers"

// Importa Bootstrap desde CDN
import * as bootstrap from "bootstrap"

// Re-inicializar Bootstrap cada vez que Turbo cambia de página
document.addEventListener("turbo:load", () => {
  // Dropdowns
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(el => {
    new bootstrap.Dropdown(el)
  })

  // Tooltips (si querés usarlos más adelante)
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el)
  })

  // Popovers (si los necesitás)
  document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => {
    new bootstrap.Popover(el)
  })
})
