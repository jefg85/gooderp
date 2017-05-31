class Inventario::ProductoDetallesController < PrivateController
  before_action :set_inventario_producto_detalle, only: [:show, :edit, :update, :destroy]

  # GET /inventario/producto_detalles
  # GET /inventario/producto_detalles.json
  def index
    @inventario_producto_detalles = Inventario::ProductoDetalle.all
  end

  # GET /inventario/producto_detalles/1
  # GET /inventario/producto_detalles/1.json
  def show
  end

  # GET /inventario/producto_detalles/new
  def new
    @inventario_producto_detalle = Inventario::ProductoDetalle.new
  end

  # GET /inventario/producto_detalles/1/edit
  def edit
  end

  # POST /inventario/producto_detalles
  # POST /inventario/producto_detalles.json
  def create
    @inventario_producto_detalle = Inventario::ProductoDetalle.new(inventario_producto_detalle_params)

    respond_to do |format|
      if @inventario_producto_detalle.save
        format.html { redirect_to @inventario_producto_detalle, notice: 'Producto detalle was successfully created.' }
        format.json { render :show, status: :created, location: @inventario_producto_detalle }
      else
        format.html { render :new }
        format.json { render json: @inventario_producto_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventario/producto_detalles/1
  # PATCH/PUT /inventario/producto_detalles/1.json
  def update
    respond_to do |format|
      if @inventario_producto_detalle.update(inventario_producto_detalle_params)
        format.html { redirect_to @inventario_producto_detalle, notice: 'Producto detalle was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventario_producto_detalle }
      else
        format.html { render :edit }
        format.json { render json: @inventario_producto_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventario/producto_detalles/1
  # DELETE /inventario/producto_detalles/1.json
  def destroy
    @inventario_producto_detalle.destroy
    respond_to do |format|
      format.html { redirect_to inventario_producto_detalles_url, notice: 'Producto detalle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventario_producto_detalle
      @inventario_producto_detalle = Inventario::ProductoDetalle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventario_producto_detalle_params
      params.require(:inventario_producto_detalle).permit(:producto_id, :nombre, :descripcion)
    end

end
