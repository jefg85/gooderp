class Facturacion::FacturacionCuentasController < PrivateController
  def index
    @agrupador_id = params[:agrupador]
    @buscar = params[:buscar].to_s
    @cuentas = Facturacion::Cuentum.joins(:rel_cliente,{:rel_cuenta_detalle=>{:rel_pedido=>:rel_pedido_detalle}})
                                   .select('clientes.agrupador_cliente_id, cuenta.id,
                                           cuenta.fecha_inicio, cuenta.fecha_fin,
                                           concat_ws(\' \',primer_apellido, segundo_apellido,
                                           primer_nombre, segundo_nombre) as nombre_cliente,count(distinct cuenta_detalles.id) as cantidad_pedido,sum
                                           (pedido_detalles.precio*pedido_detalles.cantidad) as monto_cuenta')
                                   .where('cuenta.situacion = 1').group('clientes.agrupador_cliente_id, cuenta.id,cuenta.fecha_inicio,
                                                                         cuenta.fecha_fin,concat_ws(\' \',primer_apellido,
                                                                         segundo_apellido, primer_nombre, segundo_nombre)')
    @cuentas = @cuentas.where('clientes.agrupador_cliente_id=?', @agrupador_id) unless @agrupador_id.blank?
    @cuentas = @cuentas.where('concat_ws(primer_apellido, segundo_apellido, primer_nombre, segundo_nombre) ilike ?',
                              '%' + @buscar + '%') unless @buscar.blank?
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

  def facturar
    cuenta_id = params[:id].to_i
    cuenta = Facturacion::Cuentum.find(cuenta_id)
    cuenta.situacion=2
    cuenta.save
    redirect_to '/facturacion/facturacion_cuentas/index', notice: 'Cuenta facturada con exito!'
  end

  private

  def autorizacion!
    authorize :controller_facturacion_cuentas_activas, :index?
  end

end
