class Ventas::PedidosController < PrivateController
  before_action :set_ventas_pedido, only: [:show, :update, :destroy]
  before_action :set_ventas_pedidos_catalogos, only: [:new, :create, :update, :destroy]
  before_action :set_ventas_pedidos_catalogos_show_edit, only: [:show]

  def index
    @fecha = params[:fecha].blank? ? Date.today : params[:fecha]
    @buscar = params[:buscar].to_s
    @agrupador = params[:agrupador]
    @plato_principal = params[:plato_principal]
    @cantidad_plato_principal = 0
    @cantidad_extras = 0
    @nombres_platos = [{}]

    @ventas_pedidos = Ventas::Pedido.select('pedidos.id, clientes.email, clientes.primer_apellido,
                                             clientes.segundo_apellido, clientes.primer_nombre,
                                             clientes.segundo_nombre, agrupador_clientes.nombre as grupo,
                                             pedidos.created_at, clientes.piso, pedidos.etiqueta')
                                    .uniq
                                    .joins({:rel_pedido_detalle => :rel_producto},
                                           {:rel_cliente => :rel_agrupador_cliente})
                                    .where('pedidos.fecha = ?', @fecha)
                                    .order('pedidos.created_at desc')

    @ventas_pedidos = @ventas_pedidos.where('clientes.agrupador_cliente_id =?', @agrupador) unless @agrupador.blank?
    @ventas_pedidos = @ventas_pedidos.where('concat_ws(primer_apellido, segundo_apellido, primer_nombre, segundo_nombre) ilike ?',
                                            '%' + @buscar + '%') unless @buscar.blank?
    @ventas_pedidos = @ventas_pedidos.where('productos.id =?', @plato_principal) unless @plato_principal.blank?


    totales = Ventas::Pedido.select('productos.id, productos.nombre,
                                    productos.categoria_producto_id, pedido_detalles.cantidad as cantidad')
                          .joins({:rel_pedido_detalle => :rel_producto},{:rel_cliente => :rel_agrupador_cliente})
                          .where('pedidos.fecha = ?', @fecha)
                          .order('pedidos.created_at desc')
    totales = totales.where('clientes.agrupador_cliente_id =?', @agrupador) unless @agrupador.blank?

    totales.each do |p|
      @nombres_platos.push({id: p.id, nombre: p.nombre})
    end

    totales = totales.where('productos.id =?', @plato_principal) unless @plato_principal.blank?

    totales.each do |p|
      @cantidad_plato_principal = @cantidad_plato_principal + p.cantidad if p.categoria_producto_id == 1
      @cantidad_extras = @cantidad_extras + p.cantidad if p.categoria_producto_id == 2
    end

    @nombres_platos.sort_by!{ |id, nombre| nombre }
    @nombres_platos.uniq!
    @agrupador_cliente = Ventas::AgrupadorCliente.activos
  end

  def new
    @ventas_pedido = Ventas::Pedido.new
  end

  def create
    @ventas_pedido = Ventas::Pedido.new(ventas_pedido_params)

    respond_to do |format|
      if @ventas_pedido.save
        format.html { redirect_to @ventas_pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @ventas_pedido }
      else
        format.html { render :new }
        format.json { render json: @ventas_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ventas_pedido.update(ventas_pedido_params)
        format.html { redirect_to @ventas_pedido, notice: 'Pedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @ventas_pedido }
      else
        format.html { render :edit }
        format.json { render json: @ventas_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ventas_pedido.destroy
    respond_to do |format|
      format.html { redirect_to ventas_pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def crear_detalle
    location = params[:location].to_i
    @producto = Inventario::Producto.find(ventas_pedido_detalle_params[:producto_id])
    @ventas_pedido_detalle = Ventas::PedidoDetalle.where(id: ventas_pedido_detalle_params[:id]).first_or_initialize
    @ventas_pedido_detalle.pedido_id = ventas_pedido_detalle_params[:pedido_id]
    @ventas_pedido_detalle.producto_id = ventas_pedido_detalle_params[:producto_id]
    @ventas_pedido_detalle.cantidad = ventas_pedido_detalle_params[:cantidad]
    if @ventas_pedido_detalle.new_record?
      @ventas_pedido_detalle.precio = @producto.precio unless @ventas_pedido_detalle.precio.present?
    else
      @ventas_pedido_detalle.precio = ventas_pedido_detalle_params[:precio]
    end
    @ventas_pedido_detalle.producto_complemento_id = ventas_pedido_detalle_params[:producto_complemento_id]
    @ventas_pedido_detalle.observacion = ventas_pedido_detalle_params[:observacion]
    @ventas_pedido_detalle.save

    @ventas_pedido = Ventas::Pedido.find(@ventas_pedido_detalle.pedido_id)
    if location == 0
      redirect_to @ventas_pedido, notice: 'Detalle guardado exitosamente!'
    else
      redirect_to new_ventas_pedido_url, notice: 'Detalle guardado exitosamente!'
    end
  end

  def borrar_detalle
    @ventas_pedido_detalle = Ventas::PedidoDetalle.find(params[:id])
    @ventas_pedido = Ventas::Pedido.find(@ventas_pedido_detalle.pedido_id)
    @ventas_pedido_detalle.destroy
    redirect_to @ventas_pedido, notice: 'Detalle eliminado exitosamente!'
  end

  def rpt_lista_pedidos
    fecha = params[:imprimir_pedidos_fecha]
    agrupador = params[:imprimir_pedidos_agrupador]
    server = Utils::Jasperserver.new('GE_VT001', :PDF)
    server.agregar_parametro('fecha',fecha)
    server.agregar_parametro('agrupador_cliente_id',agrupador)
    send_data server.ejecutar_reporte, type: server.obtener_content_type, filename: server.obtener_nombre, disposition: 'inline'
  end

  def rpt_orden_trabajo
   fecha = params[:imprimir_orden_fecha]
   server = Utils::Jasperserver.new('GE_VT002', :PDF)
   server.agregar_parametro('fecha',fecha)
   send_data server.ejecutar_reporte, type: server.obtener_content_type, filename: server.obtener_nombre, disposition: 'inline'
  end

  def rpt_etiqueta_individual
    id = params[:id]
    server = Utils::Jasperserver.new('GE_VT003', :PDF)
    server.agregar_parametro('id',id)
    send_data server.ejecutar_reporte, type: server.obtener_content_type, filename: server.obtener_nombre, disposition: 'inline'
  end

  def etiqueta
    begin
      result = true
      message = ''
      pedido = Ventas::Pedido.find(params[:id])
      pedido.toggle(:etiqueta)
      pedido.save!
    rescue StandardError => e
      result = false
      message = e.mesage
    ensure
      render json: { result: result, message: message, etiqueta: pedido.etiqueta }
    end
  end

  def credito_contado
    begin
      result = true
      message = ''
      pedido = nil
      ActiveRecord::Base.transaction do
        pedido = Ventas::Pedido.find(params[:id])

        unless pedido.rel_cuenta_detalle.present?
          message = 'Agregado a la cuenta correctamente'
          cuenta = Facturacion::Cuentum.where(cliente_id: pedido.cliente_id, situacion: 0)
          cuenta_activa = if cuenta.blank?
                            nueva_cuenta = Facturacion::Cuentum.new
                            nueva_cuenta.fecha_inicio = pedido.fecha
                            nueva_cuenta.cliente_id = pedido.cliente_id
                            nueva_cuenta.situacion = 0
                            nueva_cuenta.save!
                            nueva_cuenta
                          else
                            cuenta.first
                          end

          cuenta_detalle = Facturacion::CuentaDetalle.new
          cuenta_detalle.cuenta_id = cuenta_activa.id
          cuenta_detalle.pedido_id = pedido.id
          cuenta_detalle.save!

      else
        message = 'El pedido se saco de la cuenta y quedo al contado'
        pedido.rel_cuenta_detalle.destroy!
      end
    end
    rescue StandardError => e
      result = false
      message = e.mesage
    ensure
      render json: { result: result, message: message, contado: !pedido.rel_cuenta_detalle.present?}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventas_pedido
      @ventas_pedido = Ventas::Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventas_pedido_params
      params.require(:ventas_pedido).permit(:fecha, :cliente_id)
    end

    def set_ventas_pedidos_catalogos
      @clientes = Ventas::Cliente.select("id, concat_ws(' ',email,'-',primer_apellido,segundo_apellido,primer_nombre,segundo_apellido) as nombre").order('email')
    end

    def set_ventas_pedidos_catalogos_show_edit
      @cliente = Ventas::Cliente.find(@ventas_pedido.cliente_id)
      @detalle = Ventas::PedidoDetalle.where(id: params[:detalle_id]).first_or_initialize
      @detalle.pedido_id = @ventas_pedido.id
      @detalle.cantidad = 1 if @detalle.new_record?
      @productos = Inventario::Producto.select("id,concat_ws(' ','( ',precio,' ) - ', nombre) as nombre_producto")
                                       .where('categoria_producto_id in (1,2)').order('nombre')
      @productos_complemento = Inventario::Producto.select("id,concat_ws(' ','( ',precio,' ) - ', nombre) as nombre_producto")
                                                   .where('categoria_producto_id=3').order('nombre')
    end

    def ventas_pedido_detalle_params
      params.require(:ventas_pedido_detalle).permit(:id, :pedido_id, :producto_id, :producto_complemento_id, :cantidad, :precio, :observacion)
    end

end
