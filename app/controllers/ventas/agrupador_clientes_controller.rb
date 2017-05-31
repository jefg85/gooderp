class Ventas::AgrupadorClientesController < PrivateController
  before_action :set_ventas_agrupador_cliente, only: [:show, :edit, :update, :destroy]

  # GET /ventas/agrupador_clientes
  # GET /ventas/agrupador_clientes.json
  def index
    @buscar = params[:buscar].to_s
    @ventas_agrupador_clientes = Ventas::AgrupadorCliente.select('*').order('nombre')
    @ventas_agrupador_clientes = @ventas_agrupador_clientes.where('nombre ilike ?', '%' + @buscar + '%') unless @buscar.blank?
  end

  # GET /ventas/agrupador_clientes/1
  # GET /ventas/agrupador_clientes/1.json
  def show
  end

  # GET /ventas/agrupador_clientes/new
  def new
    @ventas_agrupador_cliente = Ventas::AgrupadorCliente.new
  end

  # GET /ventas/agrupador_clientes/1/edit
  def edit
  end

  # POST /ventas/agrupador_clientes
  # POST /ventas/agrupador_clientes.json
  def create
    @ventas_agrupador_cliente = Ventas::AgrupadorCliente.new(ventas_agrupador_cliente_params)

    respond_to do |format|
      if @ventas_agrupador_cliente.save
        format.html { redirect_to @ventas_agrupador_cliente, notice: 'Agrupador cliente was successfully created.' }
        format.json { render :show, status: :created, location: @ventas_agrupador_cliente }
      else
        format.html { render :new }
        format.json { render json: @ventas_agrupador_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ventas/agrupador_clientes/1
  # PATCH/PUT /ventas/agrupador_clientes/1.json
  def update
    respond_to do |format|
      if @ventas_agrupador_cliente.update(ventas_agrupador_cliente_params)
        format.html { redirect_to @ventas_agrupador_cliente, notice: 'Agrupador cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @ventas_agrupador_cliente }
      else
        format.html { render :edit }
        format.json { render json: @ventas_agrupador_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/agrupador_clientes/1
  # DELETE /ventas/agrupador_clientes/1.json
  def destroy
    @ventas_agrupador_cliente.destroy
    respond_to do |format|
      format.html { redirect_to ventas_agrupador_clientes_url, notice: 'Agrupador cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventas_agrupador_cliente
      @ventas_agrupador_cliente = Ventas::AgrupadorCliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventas_agrupador_cliente_params
      params.require(:ventas_agrupador_cliente).permit(:nombre, :descripcion)
    end

end
