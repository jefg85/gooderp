class CreateVentasPedidos < ActiveRecord::Migration
  def change
    create_table :ventas_pedidos do |t|
      t.date :fecha
      t.integer :cliente_id

      t.timestamps null: false
    end
  end
end
