class CreateDivisions < ActiveRecord::Migration[8.0]
  def change
    create_table :divisions do |t|
      t.string :nombre, null: false

      t.timestamps
    end
    add_index :divisions, :nombre, unique: true
  end
end
