class CreateVentasClientes < ActiveRecord::Migration
  def change
    create_table :ventas_clientes do |t|
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :sexo
      t.string :cedula
      t.date :fecha_nacimiento

      t.timestamps null: false
    end
  end
end
