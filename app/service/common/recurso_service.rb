# encoding: utf-8

class Service::Common::RecursoService

  def initialize
    @recursos = [{ clave: 'GE_FT001', valor: '/reports/facturacion/GE_FT001' }]
  end

  def obtener_recurso(codigo_parametro)
    @recursos.find { |x| x[:clave] == codigo_parametro }
  end

end
