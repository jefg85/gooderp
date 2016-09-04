require 'test_helper'

class Ventas::AgrupadorClientesControllerTest < ActionController::TestCase
  setup do
    @ventas_agrupador_cliente = ventas_agrupador_clientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_agrupador_clientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_agrupador_cliente" do
    assert_difference('Ventas::AgrupadorCliente.count') do
      post :create, ventas_agrupador_cliente: { descripcion: @ventas_agrupador_cliente.descripcion, nombre: @ventas_agrupador_cliente.nombre }
    end

    assert_redirected_to ventas_agrupador_cliente_path(assigns(:ventas_agrupador_cliente))
  end

  test "should show ventas_agrupador_cliente" do
    get :show, id: @ventas_agrupador_cliente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_agrupador_cliente
    assert_response :success
  end

  test "should update ventas_agrupador_cliente" do
    patch :update, id: @ventas_agrupador_cliente, ventas_agrupador_cliente: { descripcion: @ventas_agrupador_cliente.descripcion, nombre: @ventas_agrupador_cliente.nombre }
    assert_redirected_to ventas_agrupador_cliente_path(assigns(:ventas_agrupador_cliente))
  end

  test "should destroy ventas_agrupador_cliente" do
    assert_difference('Ventas::AgrupadorCliente.count', -1) do
      delete :destroy, id: @ventas_agrupador_cliente
    end

    assert_redirected_to ventas_agrupador_clientes_path
  end
end
