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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130102163032) do

  create_table "dn_tables", :force => true do |t|
    t.integer  "jf_name_id"
    t.integer  "dn_start"
    t.integer  "dn_end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "event_type"
    t.integer  "user_id"
  end

  create_table "jf_names", :force => true do |t|
    t.string   "name"
    t.string   "ip_address"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "p_nat"
    t.string   "p_local"
    t.string   "p_suburban"
    t.string   "p_int"
    t.string   "p_emerg"
  end

  create_table "logbooks", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "log_type"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "level"
  end

  create_table "work_orders", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "s_cf_no"
    t.integer  "s_cr_no"
    t.integer  "status"
    t.string   "s_ad"
    t.string   "s_cr"
    t.string   "s_mc"
    t.string   "s_hs"
    t.string   "s_cf"
    t.string   "s_perm"
    t.string   "s_bt"
    t.string   "s_no",       :null => false
    t.string   "s_df_flag"
    t.string   "s_sg_no"
    t.string   "s_cid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "priority"
  end

end
