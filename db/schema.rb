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

ActiveRecord::Schema.define(version: 20160913000811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_votes", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.integer  "trust"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "vote_total",  default: 0
    t.string   "aasm_state"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "parent_comment_id"
    t.string   "text"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "flags", force: :cascade do |t|
    t.integer  "reason"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.integer  "trust"
    t.text     "details"
    t.boolean  "suspect",     default: false
    t.boolean  "confirmed"
    t.integer  "editor_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "dispute",     default: false
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "question_votes", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "trust"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "text"
    t.text     "details"
    t.integer  "topic_id"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug"
    t.string   "aasm_state"
    t.integer  "answers_count", default: 0
    t.integer  "vote_total",    default: 0
  end

  create_table "temporary_users", force: :cascade do |t|
    t.string   "ip_address"
    t.text     "votes"
    t.text     "questions"
    t.text     "answers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "flags"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "slug"
    t.integer  "parent_topic_id"
    t.integer  "questions_count",           default: 0
    t.integer  "recursive_questions_count", default: 0
    t.text     "recursive_subtopic_ids"
  end

  create_table "trust_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trust"
    t.integer  "event_type",    default: 0, null: false
    t.integer  "object_id"
    t.integer  "event_user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "object_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "trust",                  default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
