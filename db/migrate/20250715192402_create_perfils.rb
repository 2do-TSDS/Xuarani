class CreatePerfils < ActiveRecord::Migration[8.0]
  def change
    create_table :perfils do |t|
      t.references :personas, null: false, foreign_key: true

      t.timestamps
    end
  end
end
