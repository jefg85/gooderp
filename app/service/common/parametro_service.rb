# encoding: utf-8

class Service::Common::ParametroService

  def initialize
    @parametros = [{ clave: '001', valor: '' },
                   { clave: '002', valor: '' },
                   { clave: '003', valor: '' }]
  end

  def obtener_parametro(codigo_parametro)
    @parametros.find { |x| x[:clave] == codigo_parametro }
  end

end
