# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :avatar, presence: true
  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :search_by_resort_name, against: :resort_name,
                                          using: { tsearch: { prefix: true, dictionary: 'english' } }
    # To search against a column, pass a symbol as the :against option.
    # searches database against resort_name
    # use one of the language dictionaries, such as "english", then variants of words (e.g. "jumping" and "jumped") will match each other.
  end
