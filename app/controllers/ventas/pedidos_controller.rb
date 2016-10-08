class Ventas::PedidosController < PrivateController
  before_action :set_ventas_pedido, only: [:show, :update, :destroy]
  before_action :set_ventas_pedidos_catalogos, only: [:new, :create, :update, :destroy]
  before_action :set_ventas_pedidos_catalogos_show_edit, only: [:show]

  # GET /ventas/pedidos
  # GET /ventas/pedidos.json
  def index
    @fecha = params[:fecha].blank? ? Date.today : params[:fecha]
    @agrupador = params[:agrupador]
    @cantidad_plato_principal = 0
    @cantidad_extras = 0

    @ventas_pedidos = Ventas::Pedido.select('pedidos.id, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre,
                                             clientes.segundo_nombre, agrupador_clientes.nombre as grupo, pedidos.created_at')
                                    .joins({:rel_cliente => :rel_agrupador_cliente})
                                    .where('pedidos.fecha = ?', @fecha)
                                    .order('pedidos.created_at desc')
    @ventas_pedidos = @ventas_pedidos.where('clientes.agrupador_cliente_id =?', @agrupador) unless @agrupador.blank?


    totales = Ventas::Pedido.select('productos.categoria_producto_id')
                          .joins({:rel_pedido_detalle => :rel_producto},{:rel_cliente => :rel_agrupador_cliente})
                          .where('pedidos.fecha = ?', @fecha)
                          .order('pedidos.created_at desc')
    totales = totales.where('clientes.agrupador_cliente_id =?', @agrupador) unless @agrupador.blank?



    totales.each do |p|
      @cantidad_plato_principal = @cantidad_plato_principal + 1 if p.categoria_producto_id == 1
      @cantidad_extras = @cantidad_extras + 1 if p.categoria_producto_id == 2
    end

    @agrupador_cliente = Ventas::AgrupadorCliente.select('*').order('nombre')
  end

  # GET /ventas/pedidos/1
  # GET /ventas/pedidos/1.json
  def show
  end

  # GET /ventas/pedidos/new
  def new
    @ventas_pedido = Ventas::Pedido.new
  end

  # POST /ventas/pedidos
  # POST /ventas/pedidos.json
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

  # PATCH/PUT /ventas/pedidos/1
  # PATCH/PUT /ventas/pedidos/1.json
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

  # DELETE /ventas/pedidos/1
  # DELETE /ventas/pedidos/1.json
  def destroy
    @ventas_pedido.destroy
    respond_to do |format|
      format.html { redirect_to ventas_pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def crear_detalle
    @ventas_pedido_detalle = Ventas::PedidoDetalle.new(ventas_pedido_detalle_params)

    @producto = Inventario::Producto.find(@ventas_pedido_detalle.producto_id)

    @ventas_pedido_detalle.precio = @producto.precio
    @ventas_pedido_detalle.save

    @ventas_pedido = Ventas::Pedido.find(@ventas_pedido_detalle.pedido_id)
    redirect_to @ventas_pedido, notice: 'Detalle creado exitosamente!'
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
   @fecha = params[:imprimir_orden_fecha]
   @productos = Ventas::Pedido.select('productos.nombre as nombre_producto,sum(pedido_detalles.cantidad) as cantidad_pedidos').joins({:rel_pedido_detalle => :rel_producto}).where('pedidos.fecha = ?', @fecha).group('productos.nombre').order('productos.nombre')
   render layout: false
  end

  def credito
    fecha = params[:fecha].blank? ? Date.today : params[:fecha]
    agrupador = params[:agrupador]

    ActiveRecord::Base.transaction do
      ventas_pedido = Ventas::Pedido.find(params[:id])
      cuenta_activa = nil
      cuenta = Facturacion::Cuentum.where('cliente_id = ? and situacion = 0', ventas_pedido.cliente_id)
      if cuenta.blank?
        cuenta_activa = Facturacion::Cuentum.new
        cuenta_activa.fecha_inicio = ventas_pedido.fecha
        cuenta_activa.cliente_id = ventas_pedido.cliente_id
        cuenta_activa.situacion = 0
        cuenta_activa.save
      else
        cuenta_activa = cuenta[0]
      end

      cuenta_detalle = Facturacion::CuentaDetalle.new
      cuenta_detalle.cuenta_id = cuenta_activa.id
      cuenta_detalle.pedido_id = ventas_pedido.id
      cuenta_detalle.save

      redirect_to ventas_pedidos_url + '?fecha='+fecha+'&agrupador='+agrupador, notice: 'El pedido se agregado a la cuenta de crédito'
    end
  end

  def contado
    fecha = params[:fecha].blank? ? Date.today : params[:fecha]
    agrupador = params[:agrupador]

    ventas_pedido = Ventas::Pedido.find(params[:id])
    cuenta_detalle = ventas_pedido.rel_cuenta_detalle
    cuenta_detalle.destroy
    redirect_to ventas_pedidos_url + '?fecha='+fecha+'&agrupador='+agrupador, notice: 'El pedido se saco de la cuenta y quedo al contado'
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
      @detalle = Ventas::PedidoDetalle.new
      @detalle.cantidad = 1
      @detalle.pedido_id = @ventas_pedido.id
      @productos = Inventario::Producto.select("id,concat_ws(' ','( ',precio,' ) - ', nombre) as nombre_producto").order('nombre')
    end

    def ventas_pedido_detalle_params
      params.require(:ventas_pedido_detalle).permit(:pedido_id, :producto_id, :cantidad, :precio)
    end

    def autorizacion!
      authorize :controller_ventas_pedidos, :index?
    end
end
