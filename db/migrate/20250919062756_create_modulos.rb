class CreateModulos < ActiveRecord::Migration[8.0]
  def change
    create_table :modulos do |t|
      t.references :materia_division, null: false, foreign_key: true
      t.integer :dia, null: false
      t.integer :cantidad, null: false

      t.timestamps
    end
  end
end
