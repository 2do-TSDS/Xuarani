class CreateDocentes < ActiveRecord::Migration[8.0]
  def change
    create_table :docentes do |t|
      t.references :perfil, null: false, foreign_key: true

      t.timestamps
    end
  end
end
