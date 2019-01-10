# create_table "indie_mark_items", force: :cascade do |t|
#   t.string "title"
#   t.text "details"
#   t.datetime "completed_at"
#   t.decimal "score"
#   t.bigint "indie_mark_level_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["indie_mark_level_id"], name: "index_indie_mark_items_on_indie_mark_level_id"
# end
#
#   create_table "indie_mark_levels", force: :cascade do |t|
#     t.string "name"
#     t.string "slug"
#     t.text "description"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["slug"], name: "index_indie_mark_levels_on_slug", unique: true
#   end

level_1 = IndieMarkLevel.create(
  name: 'Level 1',
  description: 'IndieMark Level 1 has the general theme of owning your own domain, for sign-in, and publishing posts'
)

[
  ['#ownyouridentity', 'Personal domain that you use as your primary identity on the web.', 0.2, 1.day.ago],
  ['#useyouridentity', 'Setup Web sign-in for login, create user page on indieweb.org', 0.2, 1.day.ago],
  ['#ownyourdata - two permalinks', 'Post some kind of original cont on your own site', 0.2, 1.day.ago],
  ['#ownyourdata - h-entry markup', 'h-entry mark up of posts', 0.2, 1.day.ago],
  ['search', 'Allow robots to index, post content in HTML and site-specific searchability', 0.2]
].map do |title, details, score, completed_at|
  IndieMarkItem.create(title: title,
                       details: details,
                       score: score,
                       completed_at: completed_at,
                       indie_mark_level: level_1)
end
