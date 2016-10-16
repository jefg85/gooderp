# encoding: utf-8

class Service::Common::RecursoService

  def initialize
    @recursos = [{ clave: 'GE_FT001', url: '/reportes/facturacion/GE_FT001', descripcion: '' },
                 { clave: 'GE_VT003', url: '/reportes/ventas/GE_VT003', descripcion: '' },
                 { clave: 'GE_VT002', url: '/reportes/ventas/GE_VT002', descripcion: '' },
                 { clave: 'GE_VT001', url: '/reportes/ventas/GE_VT001', descripcion: '' }]
  end

  def obtener_recurso_url(codigo_parametro)
    recurso = @recursos.find { |x| x[:clave] == codigo_parametro }
    recurso[:url]
  end

end
