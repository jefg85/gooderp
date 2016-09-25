class ControllerVentasVentaPorClientePolicy < Struct.new(:user, :controller_ventas_venta_por_cliente)
  def index?
    user.admin? || user.gerente?
  end
end