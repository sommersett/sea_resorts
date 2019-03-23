# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :signed_in_user, only: [:edit, :update, :destroy]
  # def callback
  #   response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/oauth/callback")
  #   session[:access_token] = response.access_token
  #   redirect_to new_post_path
  # end

  def new
    @user = User.new
  end
  # creates new user

  def index
    @users = User.all
  end 

  def show
    @user = User.find(params[:id])
    # next step
    @posts = @user.posts
  end
  # users show page

  def create
    @user = User.new(user_from_params)
    respond_to do |format|
    if @user.save
      log_in @user
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      #logs in upon signup
      # flash[:success] = 'Profile created'
      # redirect_to root_path
    else
      format.html { render action: new_user_path }
      format.json { render json: @user.errors, status: :unprocessable_entity }
      format.js
      end 
      # render new_user_path
    end
    # from sign up, inputs attributes from params in form
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_from_params)
      redirect_to @user
    else
      render 'edit'
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    #issue here
    flash[:success] = 'User deleted'
    redirect_to root_path
  end

  private
  def validate_params
    params.permit(:first_name, :last_name, :email, :password)
  end


  def user_from_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
  end

  def signed_in_user
    redirect_to log_in_path unless logged_in?
  end
end
