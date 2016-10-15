class ControllerFacturacionCierreCuentasActivasPolicy < Struct.new(:user, :controller_facturacion_cierre_cuentas_activas)
  def index?
    user.admin? || user.gerente?
  end
end