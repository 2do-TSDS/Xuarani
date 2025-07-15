class CreateMateriaAlumnos < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_alumnos do |t|
      t.references :materia, null: false, foreign_key: true
      t.references :alumno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
