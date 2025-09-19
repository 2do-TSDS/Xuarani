class CreatePerfils < ActiveRecord::Migration[8.0]
  def change
    create_table :perfils do |t|
      t.string :nombres
      t.string :apellidos
      t.string :dni
      t.date :fecha_nacimiento
      t.string :direccion
      t.string :telefono
      t.string :email
      t.references :user, index: {unique: true}, null: false, foreign_key: true

      t.timestamps
    end
  end
end
