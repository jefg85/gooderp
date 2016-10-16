class ControllerVentasMenuPolicy < Struct.new(:user, :controller_ventas_menu)
  def index?
    user.admin?
  end
end