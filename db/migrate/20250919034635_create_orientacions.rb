class CreateOrientacions < ActiveRecord::Migration[8.0]
  def change
    create_table :orientacions do |t|
      t.string :nombre, null: false

      t.timestamps
    end
    add_index :orientacions, :nombre, unique: true
  end
end
