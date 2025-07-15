class CreateTurnos < ActiveRecord::Migration[8.0]
  def change
    create_table :turnos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
