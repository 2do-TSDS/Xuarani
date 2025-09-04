class CreateAsistenciaGenerals < ActiveRecord::Migration[8.0]
  def change
    create_table :asistencia_generals do |t|
      t.references :alumno, null: false, foreign_key: true
      t.references :parametro, null: false, foreign_key: true
      t.string :observaciones
      t.date :fecha

      t.timestamps
    end
  end
end
