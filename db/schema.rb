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

ActiveRecord::Schema.define(version: 20161001090118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'versions', force: :cascade do |t|
    t.string   'item_type',  null: false
    t.integer  'item_id',    null: false
    t.string   'event',      null: false
    t.string   'whodunnit'
    t.text     'object'
    t.datetime 'created_at'
  end

  add_index 'versions', ['item_type', 'item_id'], name: 'index_versions_on_item_type_and_item_id', using: :btree


  create_table 'facturacion_cuenta', force: :cascade do |t|
    t.integer  'cliente_id',               null: false
    t.date     'fecha_inicio',             null: false
    t.date     'fecha_fin'
    t.integer  'situacion',    default: 0, null: false
    t.datetime 'created_at',               null: false
    t.datetime 'updated_at',               null: false
  end

  create_table 'facturacion_cuenta_detalles', force: :cascade do |t|
    t.integer  'cuenta_id',  null: false
    t.integer   'pedido_id',  null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'inventario_producto_detalles', force: :cascade do |t|
    t.integer  'producto_id'
    t.string   'nombre'
    t.string   'descripcion'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'inventario_productos', force: :cascade do |t|
    t.string   'nombre',      null: false
    t.string   'descripcion'
    t.float    'precio',      null: false
    t.boolean  'interno',     default:false, null: false
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.boolean  'pasivo',      default:false, null: false
  end

  create_table 'inventario_categoria_productos', force: :cascade do |t|
    t.string   'nombre',      null: false
    t.string   'descripcion'
    t.boolean  'pasivo',      default:false, null: false
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'seguridad_usuarios', force: :cascade do |t|
    t.string   'nombres',                             null: false
    t.string   'apellidos',                           null: false
    t.string   'referencia',                          null: false
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count',          default: 0,  null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.string   'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string   'unconfirmed_email'
    t.integer  'failed_attempts',        default: 0,  null: false
    t.string   'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.boolean  'cliente',            default: false,  null: false
    t.boolean  'vendedor',           default: false,  null: false
    t.boolean  'gerente',            default: false,  null: false
    t.boolean  'admin',              default: false,  null: false
  end

  add_index 'seguridad_usuarios', ['confirmation_token'], name: 'index_seguridad_usuarios_on_confirmation_token', unique: true, using: :btree
  add_index 'seguridad_usuarios', ['email'], name: 'index_seguridad_usuarios_on_email', unique: true, using: :btree
  add_index 'seguridad_usuarios', ['reset_password_token'], name: 'index_seguridad_usuarios_on_reset_password_token', unique: true, using: :btree
  add_index 'seguridad_usuarios', ['unlock_token'], name: 'index_seguridad_usuarios_on_unlock_token', unique: true, using: :btree

  create_table 'ventas_agrupador_clientes', force: :cascade do |t|
    t.string   'nombre'
    t.string   'descripcion'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'ventas_clientes', force: :cascade do |t|
    t.string   'primer_nombre',        limit: 30, null: false
    t.string   'segundo_nombre',       limit: 30
    t.string   'primer_apellido',      limit: 30, null: false
    t.string   'segundo_apellido',     limit: 30
    t.string   'sexo',                 limit: 1,  null: false
    t.string   'cedula',               limit: 20
    t.date     'fecha_nacimiento',                null: false
    t.datetime 'created_at',                      null: false
    t.datetime 'updated_at',                      null: false
    t.integer  'agrupador_cliente_id'
  end

  create_table 'ventas_menu_detalles', force: :cascade do |t|
    t.integer  'menu_id',     null: false
    t.integer  'producto_id', null: false
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'ventas_menus', force: :cascade do |t|
    t.date     'fecha',      null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'ventas_pedido_detalles', force: :cascade do |t|
    t.integer  'pedido_id'
    t.integer  'producto_id'
    t.integer  'cantidad'
    t.float    'precio'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'ventas_pedidos', force: :cascade do |t|
    t.date     'fecha'
    t.integer  'cliente_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

end
