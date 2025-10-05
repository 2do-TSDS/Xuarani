// app/javascript/application.js

// Activa Turbo (Hotwire) y Stimulus
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  // Tooltips
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    if (!el._tooltip) el._tooltip = new bootstrap.Tooltip(el)
  })

  // Popovers
  document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => {
    if (!el._popover) el._popover = new bootstrap.Popover(el)
  })
})

// Driver.js tour para el Panel Principal
document.addEventListener("turbo:load", () => {
  if (document.querySelector('#card-usuarios')) {
    window.startMainGuide = () => {
      const driver = window.driver.js.driver;

      const tour = driver({
        showProgress: true,
        steps: [
          {
            element: '#card-usuarios',
            popover: {
              title: 'Gestión de Usuarios',
              description: 'Aquí podés administrar usuarios, roles y perfiles.',
              side: "top",
              align: "center"
            }
          },
          {
            element: '#card-organizacion',
            popover: {
              title: 'Organización Académica',
              description: 'Gestioná cursos, divisiones y ciclos lectivos desde acá.',
              side: "top",
              align: "center"
            }
          },
          {
            element: '#card-materias',
            popover: {
              title: 'Materias',
              description: 'Accedé al panel integral de materias, docentes y alumnos.',
              side: "top",
              align: "center"
            }
          },
          {
            popover: {
              title: '¡Listo!',
              description: 'Ya conocés las funciones principales del sistema.'
            }
          }
        ]
      });

      tour.drive();
    }

    // ⚡ OPCIONAL: arrancar automáticamente la primera vez que entrás
    // window.startMainGuide();
  }
});