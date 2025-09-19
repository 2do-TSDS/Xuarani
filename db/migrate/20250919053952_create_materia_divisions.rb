class CreateMateriaDivisions < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_divisions do |t|
      t.references :materia, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true

      t.timestamps
    end
    add_index :materia_divisions, [:materia_id, :division_id], unique: true
  end
end
