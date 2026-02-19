# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_02_16_150000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "athlete_cards", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.string "name", null: false
    t.date "birth_date", null: false
    t.string "curp", null: false
    t.integer "age", null: false
    t.string "guardian_name", null: false
    t.string "phone_number", null: false
    t.string "size", null: false
    t.decimal "weight_kg", precision: 5, scale: 2
    t.decimal "height_cm", precision: 5, scale: 2
    t.integer "dominant_profile", default: 0, null: false
    t.integer "skill_level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curp"], name: "index_athlete_cards_on_curp", unique: true
    t.index ["school_id"], name: "index_athlete_cards_on_school_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "injury_reports", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.string "injury_name", null: false
    t.text "observations"
    t.date "reported_on"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id"], name: "index_injury_reports_on_athlete_card_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.bigint "season_id", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shoutout_winner"
    t.string "shotout"
    t.string "boolean"
    t.integer "home_score"
    t.integer "away_score"
    t.boolean "registered"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["season_id"], name: "index_matches_on_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.date "birthday"
    t.string "curp"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "result_paths", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.integer "term", null: false
    t.text "goal", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "term"], name: "index_result_paths_on_athlete_card_id_and_term", unique: true
    t.index ["athlete_card_id"], name: "index_result_paths_on_athlete_card_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "info"
    t.text "schedules"
    t.string "location"
    t.decimal "monthly_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.integer "home_team_score"
    t.integer "away_team_score"
    t.boolean "shotout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_scores_on_match_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_seasons_on_category_id"
  end

  create_table "tactical_developments", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.bigint "team_id", null: false
    t.bigint "category_id", null: false
    t.date "evaluated_on", null: false
    t.integer "game_vision", default: 1, null: false
    t.integer "positioning_by_role", default: 1, null: false
    t.integer "mental_anticipation", default: 1, null: false
    t.integer "environment_adaptation", default: 1, null: false
    t.integer "counteracts_opponent_actions", default: 1, null: false
    t.integer "applies_offensive_tactical_fundamentals", default: 1, null: false
    t.integer "applies_defensive_tactical_fundamentals", default: 1, null: false
    t.integer "match_interval_management", default: 1, null: false
    t.integer "initiative_decision_making", default: 1, null: false
    t.integer "improvises_under_unexpected_situation", default: 1, null: false
    t.integer "communication_during_match", default: 1, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "evaluated_on"], name: "idx_on_athlete_card_id_evaluated_on_cf6859ea27"
    t.index ["athlete_card_id"], name: "index_tactical_developments_on_athlete_card_id"
    t.index ["category_id"], name: "index_tactical_developments_on_category_id"
    t.index ["team_id"], name: "index_tactical_developments_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.integer "wins"
    t.integer "draws"
    t.integer "losses"
    t.integer "shotout_wins"
    t.integer "shotout_losses"
    t.index ["category_id"], name: "index_teams_on_category_id"
  end

  create_table "technical_developments", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.bigint "team_id", null: false
    t.bigint "category_id", null: false
    t.date "evaluated_on", null: false
    t.integer "conduction", default: 1, null: false
    t.integer "reception", default: 1, null: false
    t.integer "passing", default: 1, null: false
    t.integer "finishing", default: 1, null: false
    t.integer "dribbling", default: 1, null: false
    t.integer "throw_in", default: 1, null: false
    t.integer "heading", default: 1, null: false
    t.integer "dispossession", default: 1, null: false
    t.integer "shielding", default: 1, null: false
    t.integer "sliding_tackle", default: 1, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "evaluated_on"], name: "idx_on_athlete_card_id_evaluated_on_c81ba7c2c1"
    t.index ["athlete_card_id"], name: "index_technical_developments_on_athlete_card_id"
    t.index ["category_id"], name: "index_technical_developments_on_category_id"
    t.index ["team_id"], name: "index_technical_developments_on_team_id"
  end

  create_table "training_attendances", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.date "attended_on", null: false
    t.boolean "attended", default: true, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "attended_on"], name: "index_training_attendances_on_athlete_card_id_and_attended_on"
    t.index ["athlete_card_id"], name: "index_training_attendances_on_athlete_card_id"
  end

  create_table "training_schedules", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.integer "day_of_week", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "day_of_week"], name: "index_training_schedules_on_athlete_card_id_and_day_of_week", unique: true
    t.index ["athlete_card_id"], name: "index_training_schedules_on_athlete_card_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekend_match_attendances", force: :cascade do |t|
    t.bigint "athlete_card_id", null: false
    t.date "match_date", null: false
    t.integer "weekend_day", null: false
    t.boolean "attended", default: true, null: false
    t.string "opponent"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_card_id", "match_date"], name: "idx_on_athlete_card_id_match_date_be39d74887"
    t.index ["athlete_card_id"], name: "index_weekend_match_attendances_on_athlete_card_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "athlete_cards", "schools"
  add_foreign_key "injury_reports", "athlete_cards"
  add_foreign_key "matches", "seasons"
  add_foreign_key "matches", "teams", column: "away_team_id", on_delete: :cascade
  add_foreign_key "matches", "teams", column: "home_team_id", on_delete: :cascade
  add_foreign_key "players", "teams", on_delete: :cascade
  add_foreign_key "result_paths", "athlete_cards"
  add_foreign_key "scores", "matches"
  add_foreign_key "seasons", "categories"
  add_foreign_key "tactical_developments", "athlete_cards"
  add_foreign_key "tactical_developments", "categories"
  add_foreign_key "tactical_developments", "teams"
  add_foreign_key "teams", "categories"
  add_foreign_key "technical_developments", "athlete_cards"
  add_foreign_key "technical_developments", "categories"
  add_foreign_key "technical_developments", "teams"
  add_foreign_key "training_attendances", "athlete_cards"
  add_foreign_key "training_schedules", "athlete_cards"
  add_foreign_key "weekend_match_attendances", "athlete_cards"
end
