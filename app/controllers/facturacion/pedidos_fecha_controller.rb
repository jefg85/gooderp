class Facturacion::PedidosFechaController < PrivateController
  def index
    @fecha_inicio = params[:fecha_inicio].blank? ? Date.today : params[:fecha_inicio]
    @fecha_fin = params[:fecha_fin].blank? ? Date.today : params[:fecha_fin]
    @agrupador = params[:agrupador]
    @monto_total = 0.0

    raise 'fechas requeridas' if @fecha_inicio.blank? || @fecha_fin.blank?

    if @agrupador.blank?
      @pedidos = Ventas::Pedido.select('pedidos.fecha, count(distinct pedidos.id) as cantidad_pedidos, sum(pedido_detalles.cantidad*pedido_detalles.precio) as monto_total').joins(:rel_pedido_detalle).where('pedidos.fecha >= ? AND pedidos.fecha <= ?', @fecha_inicio, @fecha_fin).group('pedidos.fecha').order('pedidos.fecha')
    else
      @pedidos = Ventas::Pedido.select('pedidos.fecha, count(distinct pedidos.id) as cantidad_pedidos,sum(pedido_detalles.cantidad*pedido_detalles.precio) as monto_total').joins(:rel_pedido_detalle,{:rel_cliente => :rel_agrupador_cliente}).where('pedidos.fecha >= ? AND pedidos.fecha <= ? and clientes.agrupador_cliente_id =?', @fecha_inicio, @fecha_fin, @agrupador).group('pedidos.fecha').order('pedidos.fecha')
    end

    @pedidos.each { |p| @monto_total = @monto_total + p.monto_total }

    @agrupador_cliente = Ventas::AgrupadorCliente.activos
  end

end
