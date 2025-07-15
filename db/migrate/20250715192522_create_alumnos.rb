class CreateAlumnos < ActiveRecord::Migration[8.0]
  def change
    create_table :alumnos do |t|
      t.references :perfil, null: false, foreign_key: true

      t.timestamps
    end
  end
end
