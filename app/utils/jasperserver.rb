# encoding: utf-8

class Utils::Jasperserver

  attr_accessor :servidor, :usuario, :clave, :url_reporte, :formato, :codigo_reporte

  def initialize(codigo_reporte = nil, formato = nil)
    @parametros = []
    @codigo_reporte = codigo_reporte
    @formato = formato.nil? ? nil : formato
    @url_reporte = codigo_reporte.nil? ? nil : Service::Common::RecursoService.new.obtener_recurso(codigo_reporte).url
    @servidor = codigo_reporte.nil? ? nil : Service::Common::ParametroService.new.obtener_parametro('101').valor
    @usuario = codigo_reporte.nil? ? nil : Service::Common::ParametroService.new.obtener_parametro('102').valor
    @clave = codigo_reporte.nil? ? nil : Service::Common::ParametroService.new.obtener_parametro('103').valor
  end

  def agregar_parametro(codigo, valor)
    @parametros.push(codigo: codigo, valor: valor)
  end

  def obtener_content_type
    @content_type = { PDF: 'application/pdf', RTF: 'application/ms-word', XLS: 'application/vnd.xls' }
    @content_type[@formato]
  end

  def obtener_nombre
    @codigo_reporte.upcase + '_' + DateTime.now.strftime('%Y%m%d_%H%M%S') + '.' + @formato.to_s.downcase
  end

  def ejecutar_reporte
    client = Savon.client(wsdl: "#{@servidor}?wsdl", basic_auth: [@usuario, @clave], log: true, log_level: :error)

    parametros_reporte = ''

    @parametros.each { |p| parametros_reporte << "<parameter name='#{p[:codigo]}'>#{p[:valor]}</parameter>" }
    xml_string = '<request operationName=\'runReport\' >'
    xml_string << '<argument name=\'RUN_OUTPUT_FORMAT\'>'
    xml_string << @formato.to_s.upcase
    xml_string << '</argument>'
    xml_string << '<resourceDescriptor name=\'\' wsType=\'\' uriString=\''
    xml_string << @url_reporte
    xml_string << '\' isNew=\'false\'>'
    xml_string << parametros_reporte
    xml_string << '<label></label>'
    xml_string << '</resourceDescriptor>'
    xml_string << '</request>'

    response = client.call(:run_report, message: { requestXmlString: xml_string })

    response.http.body.split('Content-Id: <report>')[1].split('------=_Part_')[0].strip
  end

end
