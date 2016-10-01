class Inventario::CategoriaProducto < ActiveRecord::Base
  strip_attributes
  has_paper_trail

  has_many :rel_producto, class_name: 'Inventario::Producto', foreign_key: 'categoria_producto_id'
end
