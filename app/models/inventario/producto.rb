class Inventario::Producto < ActiveRecord::Base
	belongs_to :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'producto_id'
end
