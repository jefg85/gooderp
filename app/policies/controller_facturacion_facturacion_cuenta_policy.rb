class ControllerFacturacionFacturacionCuentaPolicy < Struct.new(:user, :controller_facturacion_facturacion_cuenta)
  def index?
    user.admin? || user.gerente?
  end
end