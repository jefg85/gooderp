class ControllerVentasClientesPolicy < Struct.new(:user, :controller_ventas_clientes)
  def index?
    user.admin? || user.vendedor? || user.gerente?
  end
end