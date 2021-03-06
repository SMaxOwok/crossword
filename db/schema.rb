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

ActiveRecord::Schema.define(version: 2019_08_30_224144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "puzzles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source", null: false
    t.date "date", null: false
    t.integer "hours", default: 0, null: false
    t.integer "minutes", default: 0, null: false
    t.integer "seconds", default: 0, null: false
    t.string "day_of_week", null: false
    t.integer "error_count", default: 0, null: false
    t.integer "revealed_count", default: 0, null: false
    t.boolean "completed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "time_taken_in_seconds", default: 0
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_puzzles_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end


  create_view "daily_stats", sql_definition: <<-SQL
      SELECT puzzles.day_of_week,
      puzzles.user_id,
      round((100.0 * ((count(*) FILTER (WHERE puzzles.completed))::numeric / (count(*))::numeric)), 2) AS percent_completed,
      (array_agg(puzzles.id ORDER BY puzzles.time_taken_in_seconds) FILTER (WHERE puzzles.completed))[1] AS fastest_puzzle_id,
      COALESCE(sum(puzzles.hours), (0)::bigint) AS hours,
      COALESCE(sum(puzzles.minutes), (0)::bigint) AS minutes,
      COALESCE(sum(puzzles.seconds), (0)::bigint) AS seconds,
      (avg(puzzles.time_taken_in_seconds) FILTER (WHERE puzzles.completed))::integer AS average_completion_time_in_seconds,
      COALESCE(sum(puzzles.error_count), (0)::bigint) AS error_count,
      COALESCE(sum(puzzles.revealed_count), (0)::bigint) AS revealed_count,
      round(avg(puzzles.error_count), 2) AS average_error_count,
      round(avg(puzzles.revealed_count), 2) AS average_revealed_count,
      COALESCE(count(*) FILTER (WHERE puzzles.completed)) AS completed_count
     FROM puzzles
    GROUP BY puzzles.user_id, puzzles.day_of_week;
  SQL
  create_view "statistics", sql_definition: <<-SQL
      SELECT round((100.0 * ((count(*) FILTER (WHERE puzzles.completed))::numeric / (count(*))::numeric)), 2) AS percent_completed,
      (avg(puzzles.time_taken_in_seconds) FILTER (WHERE puzzles.completed))::integer AS average_completion_time_in_seconds,
      COALESCE(count(*) FILTER (WHERE puzzles.completed)) AS completed_count,
      COALESCE(sum(puzzles.error_count), (0)::bigint) AS error_count,
      COALESCE(sum(puzzles.revealed_count), (0)::bigint) AS revealed_count,
      round(avg(puzzles.error_count), 2) AS average_error_count,
      round(avg(puzzles.revealed_count), 2) AS average_revealed_count,
      puzzles.user_id
     FROM (puzzles
       JOIN users ON ((puzzles.user_id = users.id)))
    GROUP BY puzzles.user_id;
  SQL
end
