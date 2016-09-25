require 'test_helper'

class Ventas::ConsultaVentaPorClienteControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get detalle" do
    get :detalle
    assert_response :success
  end

end
