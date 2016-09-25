class Facturacion::CuentasActivasController < PrivateController
  def index
    @cuentas = Facturacion::Cuentum.joins(:rel_cliente,{:rel_cuenta_detalle=>{:rel_pedido=>:rel_pedido_detalle}})
                                   .select('cuenta.id,concat_ws(\' \',primer_apellido, segundo_apellido, primer_nombre, segundo_nombre) as nombre_cliente,count(distinct cuenta_detalles.id) as cantidad_pedido,sum(pedido_detalles.precio*pedido_detalles.cantidad) as monto_cuenta')
                                   .where('cuenta.situacion = 0').group('cuenta.id,concat_ws(\' \',primer_apellido, segundo_apellido, primer_nombre, segundo_nombre)')
    @monto_total = 0.0
    @cuentas.each{|c| @monto_total = @monto_total + c.monto_cuenta}
    @agrupador_cliente = Ventas::AgrupadorCliente.select('*').order('nombre')
  end

  def detalle
  end

  private

  def autorizacion!
    authorize :controller_facturacion_cuentas_activas, :index?
  end

end
