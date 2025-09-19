class RemoveEmailFromPerfils < ActiveRecord::Migration[8.0]
  def change
    remove_column :perfils, :email, :string
  end
end
