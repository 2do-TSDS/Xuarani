class CreateModulos < ActiveRecord::Migration[8.0]
  def change
    create_table :modulos do |t|
      t.references :materia_docente, null: false, foreign_key: true
      t.integer :dia
      t.integer :cantidad

      t.timestamps
    end
  end
end
