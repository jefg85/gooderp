class ControllerFacturacionCuentasPorClientePolicy < Struct.new(:user, :controller_facturacion_cuentas_por_cliente)
  def index?
    user.admin? || user.gerente?
  end
end