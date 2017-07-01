class Facturacion::CuentaController < ApplicationController
  def index
    @agrupador_cliente = Ventas::AgrupadorCliente.select('*').order('nombre')
    @situaciones = [{ id: 0, nombre: 'Abierto'}, { id: 1, nombre: 'Cerrado'}]
    @agrupador_id = params[:agrupador]
    @situacion = params[:situacion].to_i
    @buscar = params[:buscar].to_s
    @monto_total = 0.0
    @fecha = params[:fecha]    
    @fecha.strip! unless @fecha.blank?

    @cuentas = Facturacion::Cuentum.includes(:rel_cliente).where('cuenta.situacion= ?', @situacion).order(:fecha_inicio)
    @cuentas = @cuentas.where('fecha_inicio between ? and ?', @fecha.split(' ')[0], @fecha.split(' ')[2]) unless @fecha.blank?
    @cuentas = @cuentas.where('clientes.agrupador_cliente_id=?', @agrupador_id).references(:rel_cliente) unless @agrupador_id.blank?
    unless @buscar.blank?
      @cuentas = @cuentas.where('concat_ws(primer_apellido, segundo_apellido, primer_nombre, segundo_nombre) ilike ?',
                                '%' + @buscar + '%')
    end
    @cuentas.each{|c| @monto_total += c.detalle_cuenta[:monto_total_cuenta]}
  end

  def detalle
    @cuenta_id = params[:id].to_i
    @cuenta = Facturacion::Cuentum.find(@cuenta_id)
    @pedidos = Ventas::Pedido.select('pedidos.id, pedidos.fecha, clientes.email, clientes.primer_apellido, 
                                      clientes.segundo_apellido, clientes.primer_nombre, clientes.segundo_nombre, 
                                      agrupador_clientes.nombre as grupo')
                              .joins(:rel_cuenta_detalle,{:rel_cliente => :rel_agrupador_cliente})
                              .where('cuenta_detalles.cuenta_id = ?', @cuenta_id).order('pedidos.fecha')
  end

  def imprimir_cuenta
    cuenta_id = params[:id].to_i
    server = Utils::Jasperserver.new('GE_FT001', :PDF)
    server.agregar_parametro('cuenta_id',cuenta_id)
    send_data server.ejecutar_reporte, type: server.obtener_content_type, filename: server.obtener_nombre, disposition: 'inline'
  end

  def cerrar_cuentas
    begin
      binding.pry
      agrupador_id = params[:agrupador]
      fecha = params[:fecha].strip!.split(' ')[2]
      cuentas = Facturacion::Cuentum.joins(:rel_cliente).select('*').where('cuenta.situacion = 0 and clientes.agrupador_cliente_id=?',agrupador_id)
      cuentas.update_all(fecha_fin: fecha, situacion: 1)
      flash[:notice] = 'Cuentas cerradas correctamente'
    rescue StandardError => e
      flash[:error] = 'Error al cerrar cuentas: ' + e.message
    ensure
      redirect_to '/facturacion/cuentas/index?agrupador=' + agrupador_id
    end    
  end

  def abrir_cerrar_cuenta
    begin
      id = params[:id]
      result = true
      cuenta = Facturacion::Cuentum.find(id)
      if cuenta.es_activa?
        cuenta.fecha_fin = Date.today
        cuenta.situacion = 1
        message = 'Cuenta cerrada correctamente'
      else
        raise 'Solo se puede abrir la última cuenta de este cliente' unless cuenta.es_ultima_cuenta?
        cuenta.fecha_fin = nil
        cuenta.situacion = 0
        cuenta.save!
        message = 'Cuenta abierta correctamente' 
      end      
      cuenta.save!
    rescue StandardError => e
      result = false
      message = e.message
    ensure
      render json: { result: result, message: message, situacion: cuenta.situacion}     
    end
  end

end
