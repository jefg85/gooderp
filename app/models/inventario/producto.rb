class Inventario::Producto < ActiveRecord::Base
	strip_attributes
	belongs_to :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'producto_id'
end
