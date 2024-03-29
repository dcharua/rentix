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

ActiveRecord::Schema.define(version: 20170831000107) do

  create_table "categoria", force: :cascade do |t|
    t.string   "categoria"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categoria", ["user_id"], name: "index_categoria_on_user_id"

  create_table "gastos", force: :cascade do |t|
    t.integer  "categoria_id"
    t.integer  "monto"
    t.date     "fecha"
    t.string   "comentarios"
    t.integer  "user_id"
    t.integer  "propiedad_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "gastos", ["categoria_id"], name: "index_gastos_on_categoria_id"
  add_index "gastos", ["propiedad_id"], name: "index_gastos_on_propiedad_id"
  add_index "gastos", ["user_id"], name: "index_gastos_on_user_id"

  create_table "inquilinos", force: :cascade do |t|
    t.string   "nombre"
    t.date     "nacimiento"
    t.string   "nacionalidad"
    t.string   "curp"
    t.string   "rfc"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "inquilinos", ["user_id"], name: "index_inquilinos_on_user_id"

  create_table "pagos", force: :cascade do |t|
    t.integer  "rentas_id"
    t.integer  "categoria_id"
    t.integer  "monto"
    t.date     "fecha"
    t.date     "mes"
    t.string   "comentarios"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "pagos", ["categoria_id"], name: "index_pagos_on_categoria_id"
  add_index "pagos", ["rentas_id"], name: "index_pagos_on_rentas_id"
  add_index "pagos", ["user_id"], name: "index_pagos_on_user_id"

  create_table "plazos", force: :cascade do |t|
    t.integer  "rentas_id"
    t.date     "inicio"
    t.date     "final"
    t.integer  "costo"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "plazos", ["rentas_id"], name: "index_plazos_on_rentas_id"
  add_index "plazos", ["user_id"], name: "index_plazos_on_user_id"

  create_table "propiedads", force: :cascade do |t|
    t.string   "nombre"
    t.string   "calle"
    t.string   "municipio"
    t.string   "colonia"
    t.integer  "numero"
    t.string   "numeroe"
    t.integer  "cp"
    t.string   "estado"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "propiedads", ["user_id"], name: "index_propiedads_on_user_id"

  create_table "rentas", force: :cascade do |t|
    t.integer  "inquilino_id"
    t.integer  "propiedad_id"
    t.date     "inicio"
    t.date     "final"
    t.integer  "costo"
    t.integer  "dia"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "rentas", ["inquilino_id"], name: "index_rentas_on_inquilino_id"
  add_index "rentas", ["propiedad_id"], name: "index_rentas_on_propiedad_id"
  add_index "rentas", ["user_id"], name: "index_rentas_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.text     "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
