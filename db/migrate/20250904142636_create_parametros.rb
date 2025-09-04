class CreateParametros < ActiveRecord::Migration[8.0]
  def change
    create_table :parametros do |t|
      t.string :abreviacion
      t.string :nombre
      t.integer :valor

      t.timestamps
    end
  end
end
