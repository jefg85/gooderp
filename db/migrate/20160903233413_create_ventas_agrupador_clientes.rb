class CreateVentasAgrupadorClientes < ActiveRecord::Migration
  def change
    create_table :ventas_agrupador_clientes do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
