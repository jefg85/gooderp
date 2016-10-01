class Ventas::AgrupadorCliente < ActiveRecord::Base
	strip_attributes
	has_paper_trail
	has_many :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'id'
end
