class Inventario::Producto < ActiveRecord::Base
	strip_attributes
	has_paper_trail
	belongs_to :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'producto_id'
end
