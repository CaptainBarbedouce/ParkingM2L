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

ActiveRecord::Schema.define(version: 20160425112702) do

  create_table "historiques", force: :cascade do |t|
    t.integer  "utilisateurs_id"
    t.integer  "placeparkings_id"
    t.datetime "date_debut",       null: false
    t.datetime "date_fin",         null: false
  end

  add_index "historiques", ["placeparkings_id"], name: "index_historiques_on_placeparkings_id"
  add_index "historiques", ["utilisateurs_id"], name: "index_historiques_on_utilisateurs_id"

  create_table "ligues", force: :cascade do |t|
    t.string "libel", limit: 50, null: false
  end

  create_table "listeattentes", force: :cascade do |t|
    t.integer "utilisateurs_id"
    t.integer "numPosition",     limit: 3, null: false
    t.integer "duration",        limit: 1, null: false
  end

  add_index "listeattentes", ["utilisateurs_id"], name: "index_listeattentes_on_utilisateurs_id"

  create_table "parkingdurations", force: :cascade do |t|
    t.integer "maxduration", default: 3, null: false
  end

  create_table "placeparkings", force: :cascade do |t|
    t.string  "libel",    limit: 2,                 null: false
    t.boolean "occupied",           default: false, null: false
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.string   "nom",                     limit: 25,                 null: false
    t.string   "prenom",                  limit: 25,                 null: false
    t.string   "adresse",                 limit: 50
    t.string   "cp",                      limit: 5
    t.string   "ville",                   limit: 50
    t.string   "tel",                     limit: 10,                 null: false
    t.boolean  "compte_accepted",                    default: false, null: false
    t.boolean  "demande_reservation",                default: true,  null: false
    t.boolean  "reservation_automatique",            default: false, null: false
    t.boolean  "admin",                              default: false
    t.integer  "ligues_id"
    t.string   "email",                                              null: false
    t.string   "encrypted_password",                                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "utilisateurs", ["email"], name: "index_utilisateurs_on_email", unique: true
  add_index "utilisateurs", ["ligues_id"], name: "index_utilisateurs_on_ligues_id"
  add_index "utilisateurs", ["reset_password_token"], name: "index_utilisateurs_on_reset_password_token", unique: true

end
