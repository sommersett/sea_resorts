# frozen_string_literal: true

class User < ApplicationRecord
  # attr_accessor :remember_token

  has_many :posts, dependent: :destroy
  has_many :authentications, dependent: :destroy
  # This would be useful if you have more than one authorization provider.
  # cannot delete if has these above
  has_secure_password
  # Bycrpt

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 250 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  mount_uploader :avatar, AvatarUploader

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
    end
  # “the password digest is created using bcrypt (via has_secure_password)”
  # password is passed into string here to create valid password digest for user

  # def self.new_token
  #   SecureRandom.urlsafe_base64
  #   end

  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  #   end

  # def authenticated?(remmeber_token)
  #   return false if remember_digest.nil?

  #   BCrypt::Password.new(remember_digest).is_password?(remmeber_token)
  #   end

  # def forget
  #   update_attribute(:remember_digest, nil)
  #   end

  def self.create_with_auth_and_hash(authentication, auth_hash)

    #creates a new user if it doesnt exist
    user = create!(
      first_name: auth_hash['info']['first_name'],
      last_name: auth_hash['info']['last_name'],
      email: auth_hash['info']['email'],
      password: SecureRandom.hex(10)
    )

    user.remote_avatar_url = auth_hash['info']['image']
    user.save
    # saves avatar
    user.authentications << authentication
    # puts into user's auth attribute
    user
  end
  # The method, create_with_auth_hash will create a User object based on the information given by the provider.

  # grab google to access google for user data, returns token
  def google_token
    x = authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
end
