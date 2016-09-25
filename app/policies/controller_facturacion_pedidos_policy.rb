class ControllerFacturacionPedidosPolicy < Struct.new(:user, :controller_facturacion_pedidos)
  def index?
    user.admin? || user.gerente?
  end
end