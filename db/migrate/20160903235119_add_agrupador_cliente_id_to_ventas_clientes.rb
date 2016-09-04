class AddAgrupadorClienteIdToVentasClientes < ActiveRecord::Migration
  def change
    add_column :ventas_clientes, :agrupador_cliente_id, :integer
  end
end
