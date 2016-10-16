class Ventas::Cliente < ActiveRecord::Base
	strip_attributes
	has_paper_trail

	belongs_to :rel_agrupador_cliente, class_name: 'Ventas::AgrupadorCliente', foreign_key: 'agrupador_cliente_id'

	def nombre_completo
		nombre_completo = self.primer_apellido
		nombre_completo << ' '
		nombre_completo << (self.segundo_apellido.nil? ? '' : self.segundo_apellido)
		nombre_completo << ' '
		nombre_completo << self.primer_nombre
		nombre_completo << ' '
		nombre_completo << (self.segundo_nombre.nil? ? '' : self.segundo_nombre)
		nombre_completo
	end

	def primer_nombre_primer_apellido_email
		nombre_completo = self.primer_nombre
		nombre_completo << '_'
		nombre_completo << self.primer_apellido
		nombre_completo << '_'
		nombre_completo << self.email
		nombre_completo.upcase
	end

end
