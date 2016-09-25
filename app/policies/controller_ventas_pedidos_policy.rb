class ControllerVentasPedidosPolicy < Struct.new(:user, :controller_ventas_pedidos)
  def index?
    user.admin? || user.vendedor? || user.gerente?
  end
end