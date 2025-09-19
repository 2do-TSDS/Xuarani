class CreateCursos < ActiveRecord::Migration[8.0]
  def change
    create_table :cursos do |t|
      t.string :nombre, null: false

      t.timestamps
    end
    add_index :cursos, :nombre, unique: true
  end
end
