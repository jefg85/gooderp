class Facturacion::CuentasPorClienteController < PrivateController
  def index
  end

  def detalle
  end

  private
  def autorizacion!
    authorize :controller_facturacion_cuentas_por_cliente, :index?
  end
end
