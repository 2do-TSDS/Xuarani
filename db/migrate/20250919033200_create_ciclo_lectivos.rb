class CreateCicloLectivos < ActiveRecord::Migration[8.0]
  def change
    create_table :ciclo_lectivos do |t|
      t.integer :año, null: false
      t.date :inicio, null: false
      t.date :final, null: false

      t.timestamps
    end
  end
end
