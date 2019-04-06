# frozen_string_literal: true

class Authentication < ApplicationRecord
  belongs_to :user

  # if user not logged in before, creates auth object, gets a new token
  def self.create_with_omniauth(auth_hash)
    new(
      provider: auth_hash['provider'],
      uid: auth_hash['uid'],
      token: auth_hash['credentials']['token']
    )
  end

    #if user logged in before
  def update_token(auth_hash)
    self.token = auth_hash['credentials']['token']
    save
  end
end
