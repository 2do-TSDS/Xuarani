class CreateMateria < ActiveRecord::Migration[8.0]
  def change
    create_table :materia do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
