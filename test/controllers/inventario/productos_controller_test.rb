require 'test_helper'

class Inventario::ProductosControllerTest < ActionController::TestCase
  setup do
    @inventario_producto = inventario_productos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventario_productos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventario_producto" do
    assert_difference('Inventario::Producto.count') do
      post :create, inventario_producto: { descripcion: @inventario_producto.descripcion, nombre: @inventario_producto.nombre }
    end

    assert_redirected_to inventario_producto_path(assigns(:inventario_producto))
  end

  test "should show inventario_producto" do
    get :show, id: @inventario_producto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventario_producto
    assert_response :success
  end

  test "should update inventario_producto" do
    patch :update, id: @inventario_producto, inventario_producto: { descripcion: @inventario_producto.descripcion, nombre: @inventario_producto.nombre }
    assert_redirected_to inventario_producto_path(assigns(:inventario_producto))
  end

  test "should destroy inventario_producto" do
    assert_difference('Inventario::Producto.count', -1) do
      delete :destroy, id: @inventario_producto
    end

    assert_redirected_to inventario_productos_path
  end
end
