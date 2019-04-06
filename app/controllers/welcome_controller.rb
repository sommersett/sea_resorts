# frozen_string_literal: true

class WelcomeController < ApplicationController
  def show
    @posts = Post.all
  end
  # homepage get

end
