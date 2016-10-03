class Inventario::ProductosController < PrivateController
  before_action :set_inventario_producto, only: [:show, :edit, :update, :destroy]
  before_action :set_catalogos, only: [:index, :new, :create, :edit, :update, :destroy]

  # GET /inventario/productos
  # GET /inventario/productos.json
  def index
    @categoria_id = params[:categoria]
    @buscar = params[:buscar].to_s
    @inventario_productos  = Inventario::Producto.select('productos.id, productos.nombre, productos.precio, categoria_productos.nombre as categoria')
                                                 .joins(:rel_categoria_producto).order('productos.nombre').page params[:page]
    @inventario_productos = @inventario_productos.where('productos.nombre ilike ?',  '%' + @buscar + '%') unless @buscar.blank?
    @inventario_productos = @inventario_productos.where(categoria_producto_id: @categoria_id) unless @categoria_id.blank?
  end

  # GET /inventario/productos/1
  # GET /inventario/productos/1.json
  def show
  end

  # GET /inventario/productos/new
  def new
    @inventario_producto = Inventario::Producto.new
  end

  # GET /inventario/productos/1/edit
  def edit
  end

  # POST /inventario/productos
  # POST /inventario/productos.json
  def create
    @inventario_producto = Inventario::Producto.new(inventario_producto_params)

    respond_to do |format|
      if @inventario_producto.save
        format.html { redirect_to @inventario_producto, notice: 'Producto was successfully created.' }
        format.json { render :show, status: :created, location: @inventario_producto }
      else
        format.html { render :new }
        format.json { render json: @inventario_producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventario/productos/1
  # PATCH/PUT /inventario/productos/1.json
  def update
    respond_to do |format|
      if @inventario_producto.update(inventario_producto_params)
        format.html { redirect_to @inventario_producto, notice: 'Producto was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventario_producto }
      else
        format.html { render :edit }
        format.json { render json: @inventario_producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventario/productos/1
  # DELETE /inventario/productos/1.json
  def destroy
    @inventario_producto.destroy
    respond_to do |format|
      format.html { redirect_to inventario_productos_url, notice: 'Producto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventario_producto
      @inventario_producto = Inventario::Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventario_producto_params
      params.require(:inventario_producto).permit(:nombre, :descripcion, :precio, :interno, :categoria_producto_id, :pasivo)
    end

    def set_catalogos
      @categorias = Inventario::CategoriaProducto.select('*').where(pasivo: false).order('nombre')
    end

    def autorizacion!
      authorize :controller_inventario_productos, :index?
    end

end
