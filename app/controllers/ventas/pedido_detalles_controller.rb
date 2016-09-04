class Ventas::PedidoDetallesController < ApplicationController
  before_action :set_ventas_pedido_detalle, only: [:show, :edit, :update, :destroy]

  # GET /ventas/pedido_detalles
  # GET /ventas/pedido_detalles.json
  def index
    @ventas_pedido_detalles = Ventas::PedidoDetalle.all
  end

  # GET /ventas/pedido_detalles/1
  # GET /ventas/pedido_detalles/1.json
  def show
  end

  # GET /ventas/pedido_detalles/new
  def new
    @ventas_pedido_detalle = Ventas::PedidoDetalle.new
  end

  # GET /ventas/pedido_detalles/1/edit
  def edit
  end

  # POST /ventas/pedido_detalles
  # POST /ventas/pedido_detalles.json
  def create
    @ventas_pedido_detalle = Ventas::PedidoDetalle.new(ventas_pedido_detalle_params)

    respond_to do |format|
      if @ventas_pedido_detalle.save
        format.html { redirect_to @ventas_pedido_detalle, notice: 'Pedido detalle was successfully created.' }
        format.json { render :show, status: :created, location: @ventas_pedido_detalle }
      else
        format.html { render :new }
        format.json { render json: @ventas_pedido_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ventas/pedido_detalles/1
  # PATCH/PUT /ventas/pedido_detalles/1.json
  def update
    respond_to do |format|
      if @ventas_pedido_detalle.update(ventas_pedido_detalle_params)
        format.html { redirect_to @ventas_pedido_detalle, notice: 'Pedido detalle was successfully updated.' }
        format.json { render :show, status: :ok, location: @ventas_pedido_detalle }
      else
        format.html { render :edit }
        format.json { render json: @ventas_pedido_detalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/pedido_detalles/1
  # DELETE /ventas/pedido_detalles/1.json
  def destroy
    @ventas_pedido_detalle.destroy
    respond_to do |format|
      format.html { redirect_to ventas_pedido_detalles_url, notice: 'Pedido detalle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventas_pedido_detalle
      @ventas_pedido_detalle = Ventas::PedidoDetalle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventas_pedido_detalle_params
      params.require(:ventas_pedido_detalle).permit(:pedido_id, :producto_id, :cantidad, :precio)
    end
end
