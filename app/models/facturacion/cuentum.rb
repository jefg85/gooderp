class Facturacion::Cuentum < ActiveRecord::Base
  strip_attributes
  belongs_to :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'cliente_id'
  has_many :rel_cuenta_detalle, class_name: 'Facturacion::CuentaDetalle', foreign_key: 'cuenta_id'

  def monto_total
    cuenta_resumen = Facturacion::CuentaDetalle.joins(:rel_pedido=>:rel_pedido_detalle)
                         .select('sum(pedido_detalles.precio*pedido_detalles.cantidad) as monto_cuenta')
                         .where('cuenta_detalles.cuenta_id = ?',self.id).group('cuenta_detalles.cuenta_id')
    cuenta_resumen.blank? ? 0.0 : cuenta_resumen[0][:monto_cuenta]
  end

  def cantidad_pedidos
    self.rel_cuenta_detalle.count
  end
end
