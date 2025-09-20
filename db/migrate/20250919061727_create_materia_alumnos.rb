class CreateMateriaAlumnos < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_alumnos do |t|
      t.references :materia_division, null: false, foreign_key: true
      t.references :alumno, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :materia_alumnos, [:materia_division_id, :alumno_id], unique: true, name: 'index_materia_alumnos_on_materia_division_id_and_alumno_id'
  end
end
