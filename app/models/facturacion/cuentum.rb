class Facturacion::Cuentum < ActiveRecord::Base
  strip_attributes
  has_paper_trail
  
  belongs_to :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'cliente_id'
  has_many :rel_cuenta_detalle, class_name: 'Facturacion::CuentaDetalle', foreign_key: 'cuenta_id'

  scope :activas, -> { where(siutacion: 0) }
  scope :inactivas, -> { where(situacion: 1) }


  def monto_total
    cuenta_resumen = Facturacion::CuentaDetalle.joins(:rel_pedido=>:rel_pedido_detalle)
                         .select('sum(pedido_detalles.precio*pedido_detalles.cantidad) as monto_cuenta')
                         .where('cuenta_detalles.cuenta_id = ?',self.id).group('cuenta_detalles.cuenta_id')
    cuenta_resumen.blank? ? 0.0 : cuenta_resumen[0][:monto_cuenta]
  end

  def cantidad_pedidos
    self.rel_cuenta_detalle.count
  end

  def detalle_cuenta
    monto_total_cuenta = 0.0
    monto_plato_principal = 0.0
    monto_extra = 0.0

    cantidad_plato_principal = 0  
    cantidad_extras = 0

    detalles = Ventas::PedidoDetalle.includes(:rel_producto)
                                    .joins(rel_pedido: :rel_cuenta_detalle)
                                    .where('facturacion.cuenta_detalles.cuenta_id = ?', self.id)

    detalles.each do |d|
      monto_total_cuenta += d.precio * d.cantidad
      monto_plato_principal += d.precio * d.cantidad if d.rel_producto.categoria_producto_id == 1
      monto_extra += d.precio * d.cantidad if d.rel_producto.categoria_producto_id == 2
      cantidad_plato_principal += 1 if d.rel_producto.categoria_producto_id == 1
      cantidad_extras += 1 if d.rel_producto.categoria_producto_id == 2
    end

    cantidad_pedido = detalles.pluck(:pedido_id).uniq

    { monto_total_cuenta: monto_total_cuenta,
      monto_plato_principal: monto_plato_principal,
      monto_extra: monto_extra,
      cantidad_pedido: cantidad_pedido.size,
      cantidad_plato_principal: cantidad_plato_principal,
      cantidad_extras: cantidad_extras
    }

  end

  def es_ultima_cuenta?
    Facturacion::Cuentum.where(cliente_id: self.cliente_id).last.id == self.id
  end

  def es_activa?
    self.situacion.zero?
  end

end
