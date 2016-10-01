class Facturacion::CuentaDetalle < ActiveRecord::Base
  strip_attributes
  has_paper_trail

  belongs_to :rel_cuenta, class_name: 'Facturacion::Cuentum', foreign_key: 'cuenta_id'
  belongs_to :rel_pedido, class_name: 'Ventas::Pedido', foreign_key: 'pedido_id'
end
