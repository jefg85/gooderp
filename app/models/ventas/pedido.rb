class Ventas::Pedido < ActiveRecord::Base
	strip_attributes
	belongs_to :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'cliente_id'
	has_many :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'pedido_id'
end
