# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])

      # finds user by params
      # need to be valid user, and right password
      log_in user
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # remembers the session
      flash[:success] = 'Logged in'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
      # authenticate returns false
    end
  end
  # creates new session/ log in

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  # logs out/ deletes a session

  def create_from_omniauth
    auth_hash = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid']) || Authentication.create_with_omniauth(auth_hash)
    # either 
    # create_with_omniauth for authentication(create auth obj, with auth hash) or 
    # finds the authen object and updates token(with auth hash)
    
    # if: previously already logged in with OAuth, just updates token, with token, you are able to get user details and log him in
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = 'Signed in!'
    
    # else: user logs in with OAuth for the first time, creates new user with details provided in hash after providing authen token
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = edit_user_path(user)
      # so to edit the profile with a password
      @notice = 'User created. Please confirm or edit details'
    end

    log_in(user)
    redirect_to @next, notice: @notice
  end
end
