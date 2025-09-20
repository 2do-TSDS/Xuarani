class CreateParametros < ActiveRecord::Migration[8.0]
  def change
    create_table :parametros do |t|
      t.string :abreviacion, null: false
      t.string :nombre, null: false
      t.integer :valor, null: false

      t.timestamps
    end
    add_index :parametros, :abreviacion, unique: true
  end
end
