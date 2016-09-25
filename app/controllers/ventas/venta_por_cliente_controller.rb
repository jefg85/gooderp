class Ventas::VentaPorClienteController < PrivateController
  def index
  end

  def detalle
  end

  private
  def autorizacion!
    authorize :controller_ventas_venta_por_cliente, :index?
  end
end
