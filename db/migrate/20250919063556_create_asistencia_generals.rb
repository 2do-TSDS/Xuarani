class CreateAsistenciaGenerals < ActiveRecord::Migration[8.0]
  def change
    create_table :asistencia_generals do |t|
      t.references :alumno, null: false, foreign_key: { to_table: :users }
      t.references :parametro, null: false, foreign_key: true
      t.text :observaciones
      t.date :fecha, null: false

      t.timestamps
    end
    add_index :asistencia_generals, [:alumno_id, :fecha], unique: true, name: "idx_asist_gen_alumno_fecha"
    add_index :asistencia_generals, :fecha
  end
end
