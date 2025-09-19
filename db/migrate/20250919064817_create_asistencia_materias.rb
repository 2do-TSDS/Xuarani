class CreateAsistenciaMaterias < ActiveRecord::Migration[8.0]
  def change
    create_table :asistencia_materias do |t|
      t.references :materia_alumno, null: false, foreign_key: true
      t.references :parametro, null: false, foreign_key: true
      t.text :observaciones
      t.date :fecha, null: false
      t.integer :modulo, null: false

      t.timestamps
    end
    add_index :asistencia_materias, [:materia_alumno_id, :fecha, :modulo], unique: true, name: "idx_asist_materia_unica_por_modulo_dia"
    add_check_constraint :asistencia_materias, "modulo >= 1", name: "chk_asist_materia_modulo_min"
  end
end
