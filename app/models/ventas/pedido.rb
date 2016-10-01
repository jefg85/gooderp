class Ventas::Pedido < ActiveRecord::Base
	strip_attributes
	has_paper_trail

	belongs_to :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'cliente_id'
	has_many :rel_pedido_detalle, class_name: 'Ventas::PedidoDetalle', foreign_key: 'pedido_id'
	has_one :rel_cuenta_detalle, class_name: 'Facturacion::CuentaDetalle', foreign_key:  'pedido_id'

	def al_credito?
		self.rel_cuenta_detalle.present?
	end

end
