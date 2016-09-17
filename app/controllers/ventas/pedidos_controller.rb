class Ventas::PedidosController < PrivateController
  before_action :set_ventas_pedido, only: [:show, :edit, :update, :destroy]

  # GET /ventas/pedidos
  # GET /ventas/pedidos.json
  def index
    @ventas_pedidos = Ventas::Pedido.select('pedidos.id, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre, clientes.segundo_nombre, agrupador_clientes.nombre as grupo').joins({:rel_cliente => :rel_agrupador_cliente})
  end

  # GET /ventas/pedidos/1
  # GET /ventas/pedidos/1.json
  def show
  end

  # GET /ventas/pedidos/new
  def new
    @ventas_pedido = Ventas::Pedido.new
  end

  # GET /ventas/pedidos/1/edit
  def edit
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventas_pedido
      @ventas_pedido = Ventas::Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventas_pedido_params
      params.require(:ventas_pedido).permit(:fecha, :cliente_id)
    end
end
