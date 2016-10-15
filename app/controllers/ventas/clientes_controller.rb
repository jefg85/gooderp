class Ventas::ClientesController < PrivateController
  before_action :set_ventas_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_ventas_cliente_catalogos, only: [:new, :create, :edit, :update, :destroy]

  # GET /ventas/clientes
  # GET /ventas/clientes.json
  def index
    @agrupador = params[:agrupador]
    @buscar = params[:buscar].to_s
    @ventas_clientes = Ventas::Cliente.select('clientes.id, clientes.email, clientes.primer_apellido, clientes.segundo_apellido, clientes.primer_nombre,
                                              clientes.segundo_nombre, agrupador_clientes.nombre as grupo').joins(:rel_agrupador_cliente)
                                                                                                           .order('grupo, primer_apellido')
                                                                                                           .page params[:page]
    @ventas_clientes = @ventas_clientes.where('clientes.agrupador_cliente_id =?', @agrupador) unless @agrupador.blank?
    @ventas_clientes = @ventas_clientes.where('concat_ws(primer_apellido, segundo_apellido, primer_nombre, segundo_nombre) ilike ?',
                                            '%' + @buscar + '%') unless @buscar.blank?
    @agrupador_cliente = Ventas::AgrupadorCliente.select('*').order('nombre')
  end

  # GET /ventas/clientes/1
  # GET /ventas/clientes/1.json
  def show
  end

  # GET /ventas/clientes/new
  def new
    @ventas_cliente = Ventas::Cliente.new
  end

  # GET /ventas/clientes/1/edit
  def edit
  end

  # POST /ventas/clientes
  # POST /ventas/clientes.json
  def create
    @ventas_cliente = Ventas::Cliente.new(ventas_cliente_params)

    respond_to do |format|
      if @ventas_cliente.save
        format.html { redirect_to @ventas_cliente, notice: 'Cliente was successfully created.' }
        format.json { render :show, status: :created, location: @ventas_cliente }
      else
        format.html { render :new }
        format.json { render json: @ventas_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ventas/clientes/1
  # PATCH/PUT /ventas/clientes/1.json
  def update
    respond_to do |format|
      if @ventas_cliente.update(ventas_cliente_params)
        format.html { redirect_to @ventas_cliente, notice: 'Cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @ventas_cliente }
      else
        format.html { render :edit }
        format.json { render json: @ventas_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/clientes/1
  # DELETE /ventas/clientes/1.json
  def destroy
    @ventas_cliente.destroy
    respond_to do |format|
      format.html { redirect_to ventas_clientes_url, notice: 'Cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventas_cliente
      @ventas_cliente = Ventas::Cliente.find(params[:id])
    end

    def set_ventas_cliente_catalogos
      @agrupador = Ventas::AgrupadorCliente.select('*').order('nombre')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventas_cliente_params
      params.require(:ventas_cliente).permit(:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :cedula, :fecha_nacimiento,
                                             :agrupador_cliente_id, :email, :piso)
    end

  def autorizacion!
    authorize :controller_ventas_clientes, :index?
  end
end
