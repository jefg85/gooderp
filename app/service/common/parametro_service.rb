# encoding: utf-8

class Service::Common::ParametroService

  def initialize
    @parametros = [{ clave: '001', valor: 'http://localhost:8080/jasperserver/services/repository', descripcion: '' },
                   { clave: '002', valor: 'gooderp_user', descripcion: '' },
                   { clave: '003', valor: 'codeegood001$', descripcion: '' }]
  end

  def obtener_parametro_valor(codigo_parametro)
    parametro = @parametros.find { |x| x[:clave] == codigo_parametro }
    parametro[:valor]
  end

end
