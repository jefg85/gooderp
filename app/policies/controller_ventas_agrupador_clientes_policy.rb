class ControllerVentasAgrupadorClientesPolicy < Struct.new(:user, :controller_ventas_agrupador_cliente)
  def index?
    user.admin?
  end
end