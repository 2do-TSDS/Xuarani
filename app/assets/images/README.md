<img src="./app/assets/images/Logo2.png" alt="Logo del proyecto" width="200"/>

# Xuarani
![Static Badge](https://img.shields.io/badge/Status-En%20Desarrollo-green)

![Static Badge](https://img.shields.io/badge/BackEnd-Ruby%203.4.4%20%2B%20Rails%208.0.2-blue)

![Static Badge](https://img.shields.io/badge/FrontEnd-Bootstrap%205-purple)

![Static Badge](https://img.shields.io/badge/Auth%2FRoles-Devise%20%2B%20Cancancan-red)

Este proyecto es un sistema de gestión académica orientado a instituciones educativas. Permite administrar usuarios con distintos roles, materias, cursos, asistencias y más.

## Índice
- [Acerca del proyecto](#acerca-del-proyecto)
- [Características](#características)
- [Tecnologías utilizadas](#tecnologías-utilizadas)
- [Acceso al proyecto](#Acceso-al-proyecto)
- [Uso](#uso)
- [Personas contribuyentes](Personas-Contribuyentes)
- [Licencia](#licencia)

## Acerca del proyecto
Este sistema busca digitalizar procesos escolares mediante el registro y control de asistencias, la gestión de materias, cursos y divisiones, y la administración de usuarios con distintos niveles de acceso, todo dentro de una interfaz sencilla y adaptable a distintos dispositivos.

🚧 Este proyecto se encuentra actualmente en desarrollo activo.

## Características
- Autenticación con Devise y Cancancan (reglas por rol).
- Dashboard diferenciado por rol.
- Gestión de materias, cursos, turnos y orientaciones.
- Frontend con Tailwind CSS y/o Bootstrap 5.3.
- Bases de datos: MySQL en producción y SQLite en desarrollo.
## Tecnologías utilizadas
- **Backend:** Ruby 3.4.4 + Rails 8.0.2
- **Frontend:** Bootstrap 5
- **Base de datos:** MySQL (producción), SQLite (desarrollo)
- **Autenticación y roles:** Devise + Cancancan
- **Otros:** Yarn, Node.js

## Acceso al proyecto

Clonar el projecto

```bash
git clone https://github.com/2do-TSDS/Xuarani/
```

Go to the project directory

```bash
cd Xuarani
```

Install dependencies

```bash
bundle install
yarn install
```

Start the server

```bash
bin/rails db:create db:migrate db:seed
bin/rails server
```

## Uso
- El **Administrador** tiene control total sobre la aplicación: puede crear, modificar y eliminar cualquier recurso, incluyendo usuarios, roles, materias, cursos, turnos y orientaciones. En definitiva, gestiona toda la estructura del programa.

- El **Docente** accede únicamente a las vistas relacionadas con sus materias. Dentro de ese espacio puede administrar la asistencia de los estudiantes en cada clase, asegurando un registro claro y actualizado.

## Personas Contribuyentes
* ### Profesor Curricular
    - Juan Pedro Escapil - [juanpedroescapil](https://github.com/juanpedroescapil)
* ### Desarollo-BackEnd
    - Andres Fontana – [xAceOfSpadesx16](https://github.com/xAceOfSpadesx16)
    - Constancio Otaola - [Consty226](https://github.com/Consty226)
* ### Desarollo-FrontEnd
    - Jose Dugarte - [SygmaWalk](https://github.com/SygmaWalk)
    - Marcos Adolfo - [Markitostvs](https://github.com/Markitostvs)
    - Nicolas Parisey - [nico-p321](https://github.com/nico-p321)

## Licencia

Este proyecto está bajo la licencia [MIT](https://choosealicense.com/licenses/mit/)

