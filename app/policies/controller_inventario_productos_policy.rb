class ControllerInventarioProductosPolicy < Struct.new(:user, :controller_inventario_productos)
  def index?
    user.admin? || user.gerente?
  end
end