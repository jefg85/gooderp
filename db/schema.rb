# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160903235119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventario_producto_detalles", force: :cascade do |t|
    t.integer  "producto_id"
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "inventario_productos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ventas_agrupador_clientes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ventas_clientes", force: :cascade do |t|
    t.string   "primer_nombre",        limit: 30, null: false
    t.string   "segundo_nombre",       limit: 30
    t.string   "primer_apellido",      limit: 30, null: false
    t.string   "segundo_apellido",     limit: 30
    t.string   "sexo",                 limit: 1,  null: false
    t.string   "cedula",               limit: 20
    t.date     "fecha_nacimiento",                null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.belongs_to  :ventas_agrupador_clientes, index: true
  end

  create_table "ventas_pedido_detalles", force: :cascade do |t|
    t.integer  "pedido_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ventas_pedidos", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
