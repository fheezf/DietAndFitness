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

ActiveRecord::Schema.define(version: 20150315182256) do

  create_table "diets", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "duration"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "imagen"
    t.string   "foods"
    t.text     "description"
    t.integer  "punctuation", default: 0
  end

  create_table "diets_users", id: false, force: true do |t|
    t.integer "diet_id"
    t.integer "user_id"
  end

  add_index "diets_users", ["diet_id"], name: "index_diets_users_on_diet_id"
  add_index "diets_users", ["user_id"], name: "index_diets_users_on_user_id"

  create_table "fitnesses", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "duration"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "imagen"
    t.string   "exercises"
    t.text     "description"
    t.integer  "punctuation", default: 0
  end

  create_table "fitnesses_users", id: false, force: true do |t|
    t.integer "fitness_id"
    t.integer "user_id"
  end

  add_index "fitnesses_users", ["fitness_id"], name: "index_fitnesses_users_on_fitness_id"
  add_index "fitnesses_users", ["user_id"], name: "index_fitnesses_users_on_user_id"

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "surname"
    t.string   "hashed_password"
    t.string   "email"
  end

end
