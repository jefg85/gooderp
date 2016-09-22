require 'test_helper'

class Facturacion::ConsultaPedidosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
