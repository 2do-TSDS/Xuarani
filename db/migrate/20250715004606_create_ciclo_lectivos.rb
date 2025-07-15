class CreateCicloLectivos < ActiveRecord::Migration[8.0]
  def change
    create_table :ciclo_lectivos do |t|
      t.integer :anio
      t.date :inicio
      t.date :final

      t.timestamps
    end
  end
end
