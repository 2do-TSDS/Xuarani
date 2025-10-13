class ChangeParametrosValorToDecimal < ActiveRecord::Migration[8.0]
  def up
    # Decimal preciso, hasta 99.99
    change_column :parametros, :valor, :decimal, precision: 4, scale: 2, null: false
  end

  def down
    change_column :parametros, :valor, :integer, null: false
  end
end