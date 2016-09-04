class CreateVentasPedidoDetalles < ActiveRecord::Migration
  def change
    create_table :ventas_pedido_detalles do |t|
      t.integer :pedido_id
      t.integer :producto_id
      t.integer :cantidad
      t.float :precio

      t.timestamps null: false
    end
  end
end
