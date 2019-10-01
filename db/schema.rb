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

ActiveRecord::Schema.define(version: 2019_10_01_201706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "indie_mark_items", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.datetime "completed_at"
    t.decimal "score"
    t.bigint "indie_mark_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["indie_mark_level_id"], name: "index_indie_mark_items_on_indie_mark_level_id"
  end

  create_table "indie_mark_levels", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_indie_mark_levels_on_slug", unique: true
  end

  create_table "link_previews", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.string "summary"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author_name"
    t.string "author_photo"
    t.string "author_url"
  end

  create_table "mentions", force: :cascade do |t|
    t.bigint "post_id"
    t.string "source"
    t.string "title"
    t.string "content"
    t.string "in_reply_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target"
    t.boolean "is_like", default: false
    t.string "photo"
    t.index ["post_id"], name: "index_mentions_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "type"
    t.text "content"
    t.datetime "published_at"
    t.integer "sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "slug"
    t.string "in_reply_to"
    t.string "repost_of"
  end

  create_table "sent_mentions", force: :cascade do |t|
    t.bigint "post_id"
    t.string "target"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_sent_mentions_on_post_id"
  end

  create_table "silos", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syndicates", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "silo_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_syndicates_on_post_id"
    t.index ["silo_id"], name: "index_syndicates_on_silo_id"
  end

  add_foreign_key "indie_mark_items", "indie_mark_levels"
  add_foreign_key "mentions", "posts"
  add_foreign_key "sent_mentions", "posts"
  add_foreign_key "syndicates", "posts"
  add_foreign_key "syndicates", "silos"
end
