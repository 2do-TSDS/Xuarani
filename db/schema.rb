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

ActiveRecord::Schema[8.0].define(version: 2025_09_19_064817) do
  create_table "asistencia_generals", force: :cascade do |t|
    t.integer "alumno_id", null: false
    t.integer "parametro_id", null: false
    t.text "observaciones"
    t.date "fecha", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id", "fecha"], name: "idx_asist_gen_alumno_fecha", unique: true
    t.index ["alumno_id"], name: "index_asistencia_generals_on_alumno_id"
    t.index ["fecha"], name: "index_asistencia_generals_on_fecha"
    t.index ["parametro_id"], name: "index_asistencia_generals_on_parametro_id"
  end

  create_table "asistencia_materias", force: :cascade do |t|
    t.integer "materia_alumno_id", null: false
    t.integer "parametro_id", null: false
    t.text "observaciones"
    t.date "fecha", null: false
    t.integer "modulo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["materia_alumno_id", "fecha", "modulo"], name: "idx_asist_materia_unica_por_modulo_dia", unique: true
    t.index ["materia_alumno_id"], name: "index_asistencia_materias_on_materia_alumno_id"
    t.index ["parametro_id"], name: "index_asistencia_materias_on_parametro_id"
    t.check_constraint "modulo >= 1", name: "chk_asist_materia_modulo_min"
  end

  create_table "ciclo_lectivos", force: :cascade do |t|
    t.integer "año", null: false
    t.date "inicio", null: false
    t.date "final", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nombre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_cursos_on_nombre", unique: true
  end

  create_table "divisions", force: :cascade do |t|
    t.string "nombre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_divisions_on_nombre", unique: true
  end

  create_table "materia_alumnos", force: :cascade do |t|
    t.integer "materia_division_id", null: false
    t.integer "alumno_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_materia_alumnos_on_alumno_id"
    t.index ["materia_division_id", "alumno_id"], name: "index_materia_alumnos_on_materia_division_id_and_alumno_id", unique: true
    t.index ["materia_division_id"], name: "index_materia_alumnos_on_materia_division_id"
  end

  create_table "materia_divisions", force: :cascade do |t|
    t.integer "materia_id", null: false
    t.integer "division_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_materia_divisions_on_division_id"
    t.index ["materia_id", "division_id"], name: "index_materia_divisions_on_materia_id_and_division_id", unique: true
    t.index ["materia_id"], name: "index_materia_divisions_on_materia_id"
  end

  create_table "materia_docentes", force: :cascade do |t|
    t.integer "materia_division_id", null: false
    t.integer "docente_id", null: false
    t.boolean "titular", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["docente_id"], name: "index_materia_docentes_on_docente_id"
    t.index ["materia_division_id", "docente_id"], name: "index_materia_docentes_on_materia_division_id_and_docente_id", unique: true
    t.index ["materia_division_id"], name: "index_materia_docentes_on_materia_division_id"
  end

  create_table "materias", force: :cascade do |t|
    t.string "nombre", null: false
    t.integer "turno_id", null: false
    t.integer "curso_id", null: false
    t.integer "orientacion_id", null: false
    t.integer "ciclo_lectivo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ciclo_lectivo_id"], name: "index_materias_on_ciclo_lectivo_id"
    t.index ["curso_id"], name: "index_materias_on_curso_id"
    t.index ["nombre"], name: "index_materias_on_nombre", unique: true
    t.index ["orientacion_id"], name: "index_materias_on_orientacion_id"
    t.index ["turno_id"], name: "index_materias_on_turno_id"
  end

  create_table "modulos", force: :cascade do |t|
    t.integer "materia_division_id", null: false
    t.integer "dia", null: false
    t.integer "cantidad", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["materia_division_id"], name: "index_modulos_on_materia_division_id"
  end

  create_table "orientacions", force: :cascade do |t|
    t.string "nombre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_orientacions_on_nombre", unique: true
  end

  create_table "parametros", force: :cascade do |t|
    t.string "abreviacion", null: false
    t.string "nombre", null: false
    t.integer "valor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abreviacion"], name: "index_parametros_on_abreviacion", unique: true
  end

  create_table "perfils", force: :cascade do |t|
    t.string "nombres"
    t.string "apellidos"
    t.string "dni"
    t.date "fecha_nacimiento"
    t.string "direccion"
    t.string "telefono"
    t.string "email"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_perfils_on_user_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "turnos", force: :cascade do |t|
    t.string "nombre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_turnos_on_nombre", unique: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "asistencia_generals", "parametros"
  add_foreign_key "asistencia_generals", "users", column: "alumno_id"
  add_foreign_key "asistencia_materias", "materia_alumnos"
  add_foreign_key "asistencia_materias", "parametros"
  add_foreign_key "materia_alumnos", "materia_divisions"
  add_foreign_key "materia_alumnos", "users", column: "alumno_id"
  add_foreign_key "materia_divisions", "divisions"
  add_foreign_key "materia_divisions", "materias"
  add_foreign_key "materia_docentes", "materia_divisions"
  add_foreign_key "materia_docentes", "users", column: "docente_id"
  add_foreign_key "materias", "ciclo_lectivos"
  add_foreign_key "materias", "cursos"
  add_foreign_key "materias", "orientacions"
  add_foreign_key "materias", "turnos"
  add_foreign_key "modulos", "materia_divisions"
  add_foreign_key "perfils", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
