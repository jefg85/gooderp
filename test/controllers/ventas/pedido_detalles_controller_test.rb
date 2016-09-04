require 'test_helper'

class Ventas::PedidoDetallesControllerTest < ActionController::TestCase
  setup do
    @ventas_pedido_detalle = ventas_pedido_detalles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_pedido_detalles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_pedido_detalle" do
    assert_difference('Ventas::PedidoDetalle.count') do
      post :create, ventas_pedido_detalle: { cantidad: @ventas_pedido_detalle.cantidad, pedido_id: @ventas_pedido_detalle.pedido_id, precio: @ventas_pedido_detalle.precio, producto_id: @ventas_pedido_detalle.producto_id }
    end

    assert_redirected_to ventas_pedido_detalle_path(assigns(:ventas_pedido_detalle))
  end

  test "should show ventas_pedido_detalle" do
    get :show, id: @ventas_pedido_detalle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_pedido_detalle
    assert_response :success
  end

  test "should update ventas_pedido_detalle" do
    patch :update, id: @ventas_pedido_detalle, ventas_pedido_detalle: { cantidad: @ventas_pedido_detalle.cantidad, pedido_id: @ventas_pedido_detalle.pedido_id, precio: @ventas_pedido_detalle.precio, producto_id: @ventas_pedido_detalle.producto_id }
    assert_redirected_to ventas_pedido_detalle_path(assigns(:ventas_pedido_detalle))
  end

  test "should destroy ventas_pedido_detalle" do
    assert_difference('Ventas::PedidoDetalle.count', -1) do
      delete :destroy, id: @ventas_pedido_detalle
    end

    assert_redirected_to ventas_pedido_detalles_path
  end
end
