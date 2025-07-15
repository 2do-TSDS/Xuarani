# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_15_222510) do
  create_table "alumnos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "perfil_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_alumnos_on_perfil_id"
  end

  create_table "ciclo_lectivos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "anio"
    t.date "inicio"
    t.date "final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cursos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docentes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "perfil_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_docentes_on_perfil_id"
  end

  create_table "materia", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.bigint "turno_id", null: false
    t.bigint "curso_id", null: false
    t.bigint "orientacion_id", null: false
    t.bigint "ciclo_lectivo_id", null: false
    t.bigint "docente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ciclo_lectivo_id"], name: "index_materia_on_ciclo_lectivo_id"
    t.index ["curso_id"], name: "index_materia_on_curso_id"
    t.index ["docente_id"], name: "index_materia_on_docente_id"
    t.index ["orientacion_id"], name: "index_materia_on_orientacion_id"
    t.index ["turno_id"], name: "index_materia_on_turno_id"
  end

  create_table "materia_alumnos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "materia_id", null: false
    t.bigint "alumno_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_materia_alumnos_on_alumno_id"
    t.index ["materia_id"], name: "index_materia_alumnos_on_materia_id"
  end

  create_table "orientacions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfils", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "personas_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personas_id"], name: "index_perfils_on_personas_id"
  end

  create_table "personas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombres"
    t.string "apellidos"
    t.string "dni"
    t.date "fecha_nacimiento"
    t.string "direccion"
    t.string "telefono"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turnos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alumnos", "perfils"
  add_foreign_key "docentes", "perfils"
  add_foreign_key "materia", "ciclo_lectivos"
  add_foreign_key "materia", "cursos"
  add_foreign_key "materia", "docentes"
  add_foreign_key "materia", "orientacions"
  add_foreign_key "materia", "turnos"
  add_foreign_key "materia_alumnos", "alumnos"
  add_foreign_key "materia_alumnos", "materia", column: "materia_id"
  add_foreign_key "perfils", "personas", column: "personas_id"
end
