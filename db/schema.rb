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

ActiveRecord::Schema.define(:version => 20111003151756) do

  create_table "contest_scores", :force => true do |t|
    t.integer "contest_id",        :null => false
    t.integer "user_id",           :null => false
    t.integer "score",             :null => false
    t.string  "result",            :null => false
    t.integer "pre_contest_rank"
    t.integer "post_contest_rank"
  end

  add_index "contest_scores", ["contest_id"], :name => "index_contest_scores_on_contest_id"
  add_index "contest_scores", ["user_id"], :name => "index_contest_scores_on_user_id"

  create_table "contests", :force => true do |t|
    t.integer  "ladder_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contests", ["ladder_id"], :name => "index_contests_on_ladder_id"

  create_table "ladders", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "ladder_id",                               :null => false
    t.string   "name",                                    :null => false
    t.integer  "rank",                                    :null => false
    t.integer  "wins",                   :default => 0
    t.integer  "losses",                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_streak_type"
    t.integer  "current_streak_length",  :default => 0
    t.integer  "longest_winning_streak", :default => 0
    t.integer  "longest_losing_streak",  :default => 0
    t.float    "win_pct",                :default => 0.0
    t.integer  "wins_on_top",            :default => 0
  end

  add_index "users", ["ladder_id"], :name => "index_users_on_ladder_id"

end
