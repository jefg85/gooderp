class Ventas::AgrupadorCliente < ActiveRecord::Base
	has_many :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'id'
end
