class CreateInventarioProductos < ActiveRecord::Migration
  def change
    create_table :inventario_productos do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
