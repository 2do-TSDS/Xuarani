class CreatePersonas < ActiveRecord::Migration[8.0]
  def change
    create_table :personas do |t|
      t.string :nombres
      t.string :apellidos
      t.string :dni
      t.date :fecha_nacimiento
      t.string :direccion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end
