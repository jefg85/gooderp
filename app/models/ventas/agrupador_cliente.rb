class Ventas::AgrupadorCliente < ActiveRecord::Base

	strip_attributes
	has_paper_trail

	has_many :rel_cliente, class_name: 'Ventas::Cliente', foreign_key: 'id'

	scope :todos, -> { order(:nombre) }
	scope :activos, -> { where(pasivo: false).order(:nombre) }
	scope :pasivos, -> { where(pasivo: true).order(:nombre) }
end
