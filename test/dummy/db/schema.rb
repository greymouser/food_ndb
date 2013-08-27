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

ActiveRecord::Schema.define(version: 20130827135111) do

  create_table "food_ndb_data_sources", id: false, force: true do |t|
    t.string "id",             limit: 6,   null: false
    t.string "authors"
    t.string "title",                      null: false
    t.string "year",           limit: 4
    t.string "journal",        limit: 135
    t.string "volume_or_city", limit: 16
    t.string "issue_or_state", limit: 5
    t.string "start_page",     limit: 5
    t.string "end_page",       limit: 5
  end

  add_index "food_ndb_data_sources", ["id"], name: "index_food_ndb_data_sources_on_id", unique: true, using: :btree

  create_table "food_ndb_derivations", id: false, force: true do |t|
    t.string "code",        limit: 4,   null: false
    t.string "description", limit: 120, null: false
  end

  add_index "food_ndb_derivations", ["code"], name: "index_food_ndb_derivations_on_code", unique: true, using: :btree

  create_table "food_ndb_food_groups", id: false, force: true do |t|
    t.integer "code",        limit: 2,  null: false
    t.string  "description", limit: 60, null: false
  end

  add_index "food_ndb_food_groups", ["code"], name: "index_food_ndb_food_groups_on_code", unique: true, using: :btree

  create_table "food_ndb_food_nutrients", id: false, force: true do |t|
    t.integer "nutrient_databank_number",           limit: 3,                           null: false
    t.integer "nutrient_number",                    limit: 3,                           null: false
    t.decimal "value",                                         precision: 13, scale: 3, null: false
    t.decimal "points_of_data",                                precision: 5,  scale: 0, null: false
    t.decimal "standard_error",                                precision: 11, scale: 3
    t.string  "source_code",                        limit: 2,                           null: false
    t.string  "derivation_code",                    limit: 4
    t.string  "reference_nutrient_databank_number", limit: 5
    t.boolean "enriched"
    t.integer "number_of_studies",                  limit: 1
    t.decimal "min",                                           precision: 13, scale: 3
    t.decimal "max",                                           precision: 13, scale: 3
    t.integer "degrees_of_freedom",                 limit: 2
    t.decimal "lower_error_bound",                             precision: 13, scale: 3
    t.decimal "upper_error_bound",                             precision: 13, scale: 3
    t.string  "statistical_comments",               limit: 10
    t.string  "added_or_modified_date",             limit: 10
  end

  add_index "food_ndb_food_nutrients", ["derivation_code"], name: "index_food_ndb_food_nutrients_on_derivation_code", using: :btree
  add_index "food_ndb_food_nutrients", ["nutrient_databank_number", "nutrient_number"], name: "by_food_and_nutrient", unique: true, using: :btree
  add_index "food_ndb_food_nutrients", ["source_code"], name: "index_food_ndb_food_nutrients_on_source_code", using: :btree

  create_table "food_ndb_food_nutrients_data_sources", id: false, force: true do |t|
    t.integer "nutrient_databank_number", limit: 3, null: false
    t.integer "nutrient_number",          limit: 3, null: false
    t.string  "data_source_id",           limit: 6, null: false
  end

  add_index "food_ndb_food_nutrients_data_sources", ["nutrient_databank_number", "nutrient_number", "data_source_id"], name: "by_food_nutrient_and_data_source", unique: true, using: :btree

  create_table "food_ndb_foods", id: false, force: true do |t|
    t.integer "nutrient_databank_number", limit: 3,                                           null: false
    t.integer "food_group_code",          limit: 2,                                           null: false
    t.string  "long_description",         limit: 200,                                         null: false
    t.string  "short_description",        limit: 60,                                          null: false
    t.string  "common_names",             limit: 100
    t.string  "manufacturer_name",        limit: 65
    t.boolean "survey",                                                       default: false, null: false
    t.string  "refuse_description",       limit: 135
    t.integer "refuse_percent",           limit: 1
    t.string  "scientific_name",          limit: 65
    t.decimal "n_factor",                             precision: 6, scale: 2
    t.decimal "protein_factor",                       precision: 6, scale: 2
    t.decimal "fat_factor",                           precision: 6, scale: 2
    t.decimal "carbohydrate_factor",                  precision: 6, scale: 2
  end

  add_index "food_ndb_foods", ["food_group_code"], name: "index_food_ndb_foods_on_food_group_code", using: :btree
  add_index "food_ndb_foods", ["nutrient_databank_number"], name: "index_food_ndb_foods_on_nutrient_databank_number", unique: true, using: :btree

  create_table "food_ndb_foods_languals", id: false, force: true do |t|
    t.integer "nutrient_databank_number", limit: 3, null: false
    t.string  "langual_code",             limit: 5, null: false
  end

  add_index "food_ndb_foods_languals", ["nutrient_databank_number", "langual_code"], name: "by_ndbn_and_langual", unique: true, using: :btree

  create_table "food_ndb_footnotes", id: false, force: true do |t|
    t.integer "nutrient_databank_number", limit: 3,   null: false
    t.string  "sequence",                 limit: 4,   null: false
    t.string  "the_type",                 limit: 1,   null: false
    t.integer "nutrient_number",          limit: 3
    t.string  "the_text",                 limit: 200, null: false
  end

  add_index "food_ndb_footnotes", ["nutrient_databank_number", "sequence"], name: "by_food_and_sequence", using: :btree

  create_table "food_ndb_languals", id: false, force: true do |t|
    t.string "code",        limit: 5,   null: false
    t.string "description", limit: 140, null: false
  end

  add_index "food_ndb_languals", ["code"], name: "index_food_ndb_languals_on_code", unique: true, using: :btree

  create_table "food_ndb_nutrients", id: false, force: true do |t|
    t.integer "number",                 limit: 3,  null: false
    t.string  "units",                  limit: 7,  null: false
    t.string  "infoods_tagname",        limit: 20
    t.string  "description",            limit: 60, null: false
    t.integer "rounded_decimal_places", limit: 1,  null: false
    t.integer "sr_sort_order",          limit: 3,  null: false
  end

  add_index "food_ndb_nutrients", ["number"], name: "index_food_ndb_nutrients_on_number", unique: true, using: :btree

  create_table "food_ndb_sources", id: false, force: true do |t|
    t.integer "code",        limit: 1,  null: false
    t.string  "description", limit: 60, null: false
  end

  add_index "food_ndb_sources", ["code"], name: "index_food_ndb_sources_on_code", unique: true, using: :btree

  create_table "food_ndb_weights", id: false, force: true do |t|
    t.integer "nutrient_databank_number", limit: 3,                           null: false
    t.string  "sequence",                 limit: 2,                           null: false
    t.decimal "amount",                              precision: 8,  scale: 3, null: false
    t.string  "description",              limit: 84,                          null: false
    t.decimal "gram_weight",                         precision: 8,  scale: 1, null: false
    t.integer "points_of_data",           limit: 2
    t.decimal "standard_deviation",                  precision: 10, scale: 3
  end

  add_index "food_ndb_weights", ["nutrient_databank_number", "sequence"], name: "index_food_ndb_weights_on_nutrient_databank_number_and_sequence", unique: true, using: :btree

end
