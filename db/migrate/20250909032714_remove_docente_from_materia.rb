class RemoveDocenteFromMateria < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :materia, :docentes if foreign_key_exists?(:materia, :docentes)
    remove_index :materia, :docente_id if index_exists?(:materia, :docente_id)

    remove_column :materia, :docente_id, :bigint if column_exists?(:materia, :docente_id)
  end
end