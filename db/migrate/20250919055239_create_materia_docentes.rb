class CreateMateriaDocentes < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_docentes do |t|
      t.references :materia_division, null: false, foreign_key: true
      t.references :docente, null: false, foreign_key: { to_table: :users }
      t.boolean :titular, null: false, default: false

      t.timestamps
    end
    add_index :materia_docentes, [:materia_division_id, :docente_id], unique: true, name: "index_materia_docentes_on_materia_division_id_and_docente_id"
  end
end
