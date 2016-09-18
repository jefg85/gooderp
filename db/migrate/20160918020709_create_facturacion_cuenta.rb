class CreateFacturacionCuenta < ActiveRecord::Migration
  def change
    create_table :facturacion_cuenta do |t|
      t.integer :cliente_id,  null: false
      t.date :fecha_inicio,   null: false
      t.date :fecha_fin
      t.integer :situacion,   null: false, default: 0

      t.timestamps null: false
    end
  end
end
