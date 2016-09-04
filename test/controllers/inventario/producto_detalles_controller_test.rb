require 'test_helper'

class Inventario::ProductoDetallesControllerTest < ActionController::TestCase
  setup do
    @inventario_producto_detalle = inventario_producto_detalles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventario_producto_detalles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventario_producto_detalle" do
    assert_difference('Inventario::ProductoDetalle.count') do
      post :create, inventario_producto_detalle: { descripcion: @inventario_producto_detalle.descripcion, nombre: @inventario_producto_detalle.nombre, producto_id: @inventario_producto_detalle.producto_id }
    end

    assert_redirected_to inventario_producto_detalle_path(assigns(:inventario_producto_detalle))
  end

  test "should show inventario_producto_detalle" do
    get :show, id: @inventario_producto_detalle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventario_producto_detalle
    assert_response :success
  end

  test "should update inventario_producto_detalle" do
    patch :update, id: @inventario_producto_detalle, inventario_producto_detalle: { descripcion: @inventario_producto_detalle.descripcion, nombre: @inventario_producto_detalle.nombre, producto_id: @inventario_producto_detalle.producto_id }
    assert_redirected_to inventario_producto_detalle_path(assigns(:inventario_producto_detalle))
  end

  test "should destroy inventario_producto_detalle" do
    assert_difference('Inventario::ProductoDetalle.count', -1) do
      delete :destroy, id: @inventario_producto_detalle
    end

    assert_redirected_to inventario_producto_detalles_path
  end
end
