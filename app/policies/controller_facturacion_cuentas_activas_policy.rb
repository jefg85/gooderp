class ControllerFacturacionCuentasActivasPolicy < Struct.new(:user, :controller_facturacion_cuentas_activas)
  def index?
    user.admin? || user.gerente?
  end
end