class CreateInventarioProductoDetalles < ActiveRecord::Migration
  def change
    create_table :inventario_producto_detalles do |t|
      t.integer :producto_id
      t.string :nombre
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
