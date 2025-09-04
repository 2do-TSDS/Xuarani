class CreateMateriaDocentes < ActiveRecord::Migration[8.0]
  def change
    create_table :materia_docentes do |t|
      t.references :materia, null: false, foreign_key: true
      t.references :docente, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true

      t.timestamps
    end
  end
end
