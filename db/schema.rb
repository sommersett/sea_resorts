# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_323_194_934) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authentications', force: :cascade do |t|
    t.string 'uid'
    t.string 'token'
    t.string 'provider'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_authentications_on_user_id'
  end

  create_table 'meetups', force: :cascade do |t|
    t.string 'name'
    t.string 'location'
    t.string 'api_link'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'post_id'
    t.index ['post_id'], name: 'index_meetups_on_post_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'resort_name'
    t.string 'avatar'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'location'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'avatar'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email'
  end

  add_foreign_key 'authentications', 'users'
  add_foreign_key 'meetups', 'posts'
end
