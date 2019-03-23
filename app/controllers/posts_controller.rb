class PostsController < ApplicationController

  def new
    #get postpath
    @post = Post.new
  end

  def index
    #get postspath
    @posts = Post.all
    if params[:term]
    @posts = @posts.search_by_resort_name(params["term"])
    end 
    # if search params is entered, calls on the search_by_resort_name
    #sends a get request from the form
    #server returns results in index page
  end 

  def show
    #get postpath
    @post = Post.find(params[:id])
  end 

  def create
    #post postspath
    @post = Post.new(post_from_params)
    @post.user_id = current_user.id
      if @post.save
      flash[:success] = "Image posted!"
      redirect_to user_path(current_user)
      else 
      render :new, error: "Image wasn't posted"
      end 
  end 

  def destroy
    #post_path
    @post = Post.find(params[:id])
    @post.destroy
    # respond_to do |format|
    #   format.html { redirect_to user_path(current_user), notice: 'Post deleted' }
    #   format.js 
    # end 
    # respond_to do |f|
    #   f.html { redirect_to user_path(current_user)}
    #   f.js
    # end 
    redirect_to user_path(current_user)
    # flash[:success] = "Post deleted"
  end 

  private
    def post_from_params
    params.require(:post).permit(
    :resort_name, :location, :avatar)
    #get this from params
  end 

  def set_post
    @post = Post.find(params[:id])
  end 
end 
