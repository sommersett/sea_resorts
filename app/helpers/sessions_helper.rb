# frozen_string_literal: true

module SessionsHelper
  attr_accessor :remember_token

  def log_in(user)
    session[:user_id] = user.id
    # user.id is stored in a hash in sessions, key being user_id, value being user.id
  end

  # def remember(user)
  #   user.remember
  #   cookies.permanent.signed[:user_id] = user.id
  #   cookies.permanent[:remember_token] = user.remember_token
  #   # sets a remember_token for
  # end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # we’ll follow a common Ruby convention by storing the result of User.find_by in an instance variable”

      # if sessions' user_id is equal to user_id(url), @current_user is not nil and is returned
      # elsif (user_id = cookies.signed[:user_id])
      # user = User.find_by(id: user_id)
      #   #if user_id is equal to user_id in cookies
      #   if user && user.authenticated?(cookies[:remember_token])
      # log_in user
      # @current_user = user
      #     #returns @current_user if authenticated by remember_token
      #   end
    end
    # defines current_user
  end

  def logged_in?
    !current_user.nil?
    # predicative method if current_user is nil or not, if current_user is nil, user is not signed in
  end
  # ! means not, so current_user is not nil, so its active,
  # so logged_in true means current user is active, false of being nil

  # def forget(user)
  #   user.forget
  #   cookies.delete(:user_id)
  #   cookies.delete(:remember_token)
  #   # deletes cookies
  # end

  def log_out
    # forget(current_user)
    session.delete(:user_id)
    @current_user = nil
    # deletes the session, sets instance variable to nil
  end
end
