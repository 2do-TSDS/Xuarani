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

<<<<<<< HEAD
ActiveRecord::Schema[8.0].define(version: 2025_07_15_004606) do
  create_table "ciclo_lectivos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "anio"
    t.date "inicio"
    t.date "final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estudiantes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "dni"
    t.date "fecha_nacimiento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materia", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
=======
ActiveRecord::Schema[8.0].define(version: 2025_07_14_225700) do
  create_table "orientacions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
>>>>>>> main
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
  create_table "orientacions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

=======
>>>>>>> main
  create_table "sessions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "sessions", "users"
end
