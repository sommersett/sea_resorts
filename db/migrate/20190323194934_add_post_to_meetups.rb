# frozen_string_literal: true

class AddPostToMeetups < ActiveRecord::Migration[5.2]
  def change
    add_reference :meetups, :post, index: true
    add_foreign_key :meetups, :posts
  end
  end
