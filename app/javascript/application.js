// app/javascript/application.js

// Driver.js tour para el Panel Principal
document.addEventListener("DOMContentLoaded", () => {
  // Solo ejecutar si existen las cards del panel
  if (document.querySelector('#card-usuarios')) {
    window.startMainGuide = () => {
      // Usamos el objeto global driver
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
    };

    // ⚡ OPCIONAL: arrancar automáticamente la primera vez
    // window.startMainGuide();
  }
});
