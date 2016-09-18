class Ventas::Cliente < ActiveRecord::Base
	belongs_to :rel_agrupador_cliente, class_name: 'Ventas::AgrupadorCliente', foreign_key: 'agrupador_cliente_id'

	def nombre_completo
		self.primer_apellido + ' ' + self.segundo_apellido + ' ' + self.primer_nombre + ' ' + self.segundo_nombre
	end

end
