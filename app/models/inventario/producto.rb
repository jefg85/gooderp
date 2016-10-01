class Inventario::Producto < ActiveRecord::Base
	strip_attributes
	has_paper_trail

	has_many :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'producto_id'
  belongs_to :rel_categoria_producto, class_name: 'Inventario::CategoriaProducto', foreign_key: 'categoria_producto_id'
end
