require 'test_helper'

class Ventas::ClientesControllerTest < ActionController::TestCase
  setup do
    @ventas_cliente = ventas_clientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventas_clientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ventas_cliente" do
    assert_difference('Ventas::Cliente.count') do
      post :create, ventas_cliente: { cedula: @ventas_cliente.cedula, fecha_nacimiento: @ventas_cliente.fecha_nacimiento, primer_apellido: @ventas_cliente.primer_apellido, primer_nombre: @ventas_cliente.primer_nombre, segundo_apellido: @ventas_cliente.segundo_apellido, segundo_nombre: @ventas_cliente.segundo_nombre, sexo: @ventas_cliente.sexo }
    end

    assert_redirected_to ventas_cliente_path(assigns(:ventas_cliente))
  end

  test "should show ventas_cliente" do
    get :show, id: @ventas_cliente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ventas_cliente
    assert_response :success
  end

  test "should update ventas_cliente" do
    patch :update, id: @ventas_cliente, ventas_cliente: { cedula: @ventas_cliente.cedula, fecha_nacimiento: @ventas_cliente.fecha_nacimiento, primer_apellido: @ventas_cliente.primer_apellido, primer_nombre: @ventas_cliente.primer_nombre, segundo_apellido: @ventas_cliente.segundo_apellido, segundo_nombre: @ventas_cliente.segundo_nombre, sexo: @ventas_cliente.sexo }
    assert_redirected_to ventas_cliente_path(assigns(:ventas_cliente))
  end

  test "should destroy ventas_cliente" do
    assert_difference('Ventas::Cliente.count', -1) do
      delete :destroy, id: @ventas_cliente
    end

    assert_redirected_to ventas_clientes_path
  end
end
