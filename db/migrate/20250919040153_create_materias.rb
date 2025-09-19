class CreateMaterias < ActiveRecord::Migration[8.0]
  def change
    create_table :materias do |t|
      t.string :nombre, null: false
      t.references :turno, null: false, foreign_key: true
      t.references :curso, null: false, foreign_key: true
      t.references :orientacion, null: false, foreign_key: true
      t.references :ciclo_lectivo, null: false, foreign_key: true

      t.timestamps
    end
    add_index :materias, :nombre, unique: true
  end
end
