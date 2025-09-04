class CreateAsistenciaMateria < ActiveRecord::Migration[8.0]
  def change
    create_table :asistencia_materia do |t|
      t.references :materia_alumno, null: false, foreign_key: true
      t.integer :modulo
      t.references :parametro, null: false, foreign_key: true
      t.string :observaciones
      t.date :fecha

      t.timestamps
    end
  end
end
