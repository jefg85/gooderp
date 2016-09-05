class Ventas::PedidoDetalle < ActiveRecord::Base
	belongs_to :rel_producto, class_name: 'Inventario::Producto', foreign_key: 'producto_id'
	belongs_to :rel_pedido, class_name: 'Ventas::Pedido', foreign_key: 'pedido_id'
end
