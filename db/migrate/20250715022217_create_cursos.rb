class CreateCursos < ActiveRecord::Migration[8.0]
  def change
    create_table :cursos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
