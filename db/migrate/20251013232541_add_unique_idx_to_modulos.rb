class AddUniqueIdxToModulos < ActiveRecord::Migration[8.0]
  def change
    add_index :modulos, [:materia_division_id, :dia], unique: true, name: 'idx_modulos_md_dia_uniq'
  end

  def down
    remove_index :modulos, name: 'idx_modulos_md_dia_uniq'
  end
end