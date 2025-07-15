class CreateOrientacions < ActiveRecord::Migration[8.0]
  def change
    create_table :orientacions do |t|
      t.string :nombre

      t.timestamps
    end
    
  end
end
