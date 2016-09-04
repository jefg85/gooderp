class Ventas::Cliente < ActiveRecord::Base
	belongs_to :rel_agrupador_cliente, class_name: 'Ventas::AgrupadorCliente', foreign_key: 'agrupador_cliente_id'
end
