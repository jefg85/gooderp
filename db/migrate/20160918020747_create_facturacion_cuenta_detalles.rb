class CreateFacturacionCuentaDetalles < ActiveRecord::Migration
  def change
    create_table :facturacion_cuenta_detalles do |t|
      t.integer :cuenta_id,   null: false
      t.integer :pedido_id,    null: false

      t.timestamps null: false
    end
  end
end
