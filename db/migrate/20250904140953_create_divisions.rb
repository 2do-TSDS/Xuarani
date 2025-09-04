class CreateDivisions < ActiveRecord::Migration[8.0]
  def change
    create_table :divisions do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
