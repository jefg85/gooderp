class Facturacion::Cuentum < ActiveRecord::Base
  belongs_to :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'cliente_id'
  has_many :rel_cuenta_detalle, class_name: 'Facturacion::CuentaDetalle', foreign_key: 'cuenta_id'
end
