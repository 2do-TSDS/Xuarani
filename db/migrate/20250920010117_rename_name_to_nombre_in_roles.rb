class RenameNameToNombreInRoles < ActiveRecord::Migration[8.0]
  def change
    rename_column :roles, :name, :nombre
  end
end
