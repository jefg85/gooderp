class Ventas::PedidoDetalle < ActiveRecord::Base
	strip_attributes
	has_paper_trail

	belongs_to :rel_producto, class_name: 'Inventario::Producto', foreign_key: 'producto_id'
	belongs_to :rel_producto_complemento, class_name: 'Inventario::Producto', foreign_key: 'producto_complemento_id'
	belongs_to :rel_pedido, class_name: 'Ventas::Pedido', foreign_key: 'pedido_id'
end
