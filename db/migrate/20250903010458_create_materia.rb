class CreateMateria < ActiveRecord::Migration[8.0]
  def change
    create_table :materia do |t|
      t.references :curso, null: false, foreign_key: true
      t.references :orientacion, null: false, foreign_key: true
      t.references :ciclo_lectivo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
