class CreateMateriaAlumnos < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_alumnos, if_not_exists: true  do |t|
      t.references :materia_docente, null: false, foreign_key: true
      t.references :alumno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
