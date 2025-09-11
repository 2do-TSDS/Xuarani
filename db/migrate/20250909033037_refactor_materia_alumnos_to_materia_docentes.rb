class RefactorMateriaAlumnosToMateriaDocentes < ActiveRecord::Migration[8.0]
  def up

    add_reference :materia_alumnos, :materia_docente, null: true, foreign_key: { to_table: :materia_docentes }

    change_column_null :materia_alumnos, :materia_docente_id, false

    add_index :materia_alumnos, [:materia_docente_id, :alumno_id], unique: true,
              name: "idx_materia_alumnos_unique", if_not_exists: true

    remove_foreign_key :materia_alumnos, :materia if foreign_key_exists?(:materia_alumnos, :materia)
    remove_index :materia_alumnos, :materia_id if index_exists?(:materia_alumnos, :materia_id)
    remove_column :materia_alumnos, :materia_id, :bigint if column_exists?(:materia_alumnos, :materia_id)
  end

  def down
    add_reference :materia_alumnos, :materia, null: true, foreign_key: true
    remove_index :materia_alumnos, name: "idx_materia_alumnos_unique" if index_exists?(:materia_alumnos, name: "idx_materia_alumnos_unique")
    remove_foreign_key :materia_alumnos, :materia_docentes if foreign_key_exists?(:materia_alumnos, :materia_docentes)
    remove_column :materia_alumnos, :materia_docente_id, :bigint
    change_column_null :materia_alumnos, :materia_id, false
  end
end