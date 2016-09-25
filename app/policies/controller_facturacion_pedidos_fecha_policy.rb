class ControllerFacturacionPedidosFechaPolicy < Struct.new(:user, :controller_facturacion_pedidos_fecha)
  def index?
    user.admin? || user.gerente?
  end
end