require 'test_helper'

class Ventas::PedidosControllerTest < ActionController::TestCase
  setup do
    @ventas_pedido = ventas_pedidos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_pedidos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_pedido" do
    assert_difference('Ventas::Pedido.count') do
      post :create, ventas_pedido: { cliente_id: @ventas_pedido.cliente_id, fecha: @ventas_pedido.fecha }
    end

    assert_redirected_to ventas_pedido_path(assigns(:ventas_pedido))
  end

  test "should show ventas_pedido" do
    get :show, id: @ventas_pedido
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_pedido
    assert_response :success
  end

  test "should update ventas_pedido" do
    patch :update, id: @ventas_pedido, ventas_pedido: { cliente_id: @ventas_pedido.cliente_id, fecha: @ventas_pedido.fecha }
    assert_redirected_to ventas_pedido_path(assigns(:ventas_pedido))
  end

  test "should destroy ventas_pedido" do
    assert_difference('Ventas::Pedido.count', -1) do
      delete :destroy, id: @ventas_pedido
    end

    assert_redirected_to ventas_pedidos_path
  end
end
