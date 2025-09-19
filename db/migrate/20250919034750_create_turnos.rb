class CreateTurnos < ActiveRecord::Migration[8.0]
  def change
    create_table :turnos do |t|
      t.string :nombre, null: false

      t.timestamps
    end
    add_index :turnos, :nombre, unique: true
  end
end
