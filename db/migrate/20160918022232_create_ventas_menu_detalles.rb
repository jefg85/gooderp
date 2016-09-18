class CreateVentasMenuDetalles < ActiveRecord::Migration
  def change
    create_table :ventas_menu_detalles do |t|
      t.integer :menu_id, null: false
      t.string :producto_id, null: false

      t.timestamps null: false
    end
  end
end
