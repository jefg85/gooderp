class ControllerFacturacionCierreCuentasActivasPolicy < Struct.new(:user, :controller_facturacion_cuentas_activas_pedidos)
  def index?
    user.admin? || user.gerente?
  end
end