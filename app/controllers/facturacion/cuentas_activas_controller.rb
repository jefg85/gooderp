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
    @cuenta_id = params[:id].to_i
    @cuenta = Facturacion::Cuentum.find(@cuenta_id)
    @cliente = @cuenta.rel_cliente
    @pedidos = Ventas::Pedido.select('pedidos.id, pedidos.fecha, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre, clientes.segundo_nombre, agrupador_clientes.nombre as grupo').joins(:rel_cuenta_detalle,{:rel_cliente => :rel_agrupador_cliente}).where('cuenta_detalles.cuenta_id = ?', @cuenta_id).order('pedidos.fecha')
  end

  private

  def autorizacion!
    authorize :controller_facturacion_cuentas_activas, :index?
  end

end
