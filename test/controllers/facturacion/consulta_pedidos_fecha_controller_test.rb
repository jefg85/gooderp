require 'test_helper'

class Facturacion::ConsultaPedidosFechaControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
