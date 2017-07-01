class Facturacion::PedidosController < PrivateController
  def index
    @fecha = params[:fecha].blank? ? Date.today : params[:fecha]
    @agrupador = params[:agrupador]
    @monto_total = 0.0

    if @agrupador.blank?
      @ventas_pedidos = Ventas::Pedido.select('pedidos.id, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre, clientes.segundo_nombre, agrupador_clientes.nombre as grupo').joins({:rel_cliente => :rel_agrupador_cliente}).where('pedidos.fecha = ?', @fecha)
      @monto_total = Ventas::Pedido.select('sum(pedido_detalles.cantidad*pedido_detalles.precio) as monto_total').joins(:rel_pedido_detalle).where('pedidos.fecha = ?', @fecha)[0]
    else
      @ventas_pedidos = Ventas::Pedido.select('pedidos.id, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre, clientes.segundo_nombre, agrupador_clientes.nombre as grupo').joins({:rel_cliente => :rel_agrupador_cliente}).where('pedidos.fecha = ? and clientes.agrupador_cliente_id =?', @fecha, @agrupador)
      @monto_total = Ventas::Pedido.select('sum(pedido_detalles.cantidad*pedido_detalles.precio) as monto_total').joins(:rel_pedido_detalle,{:rel_cliente => :rel_agrupador_cliente}).where('pedidos.fecha = ? and clientes.agrupador_cliente_id =?', @fecha, @agrupador)[0]
    end

    @agrupador_cliente = Ventas::AgrupadorCliente.activos
  end

end
