class CreateVentasMenus < ActiveRecord::Migration
  def change
    create_table :ventas_menus do |t|
      t.date :fecha, null: false

      t.timestamps null: false
    end
  end
end
