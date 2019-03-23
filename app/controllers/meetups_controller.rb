# frozen_string_literal: true

class MeetupsController < ApplicationController
  require 'json'

  def index
    @post = Post.find(params[:post_id])
    # p @post
    @location = @post.location
    # p @location
    @events = Meetup.new.events(@location)
    # render json: @events
    @array_of_groups = []
    @events.each do |x|
      p x['name']
      @array_of_groups << x['name']
    end

    # if Meetup.where(name: x['name']).first == nil
    # @meetup.name = x['name']
    #   @meetup.save

    # @array_of_groups << @meetupgroup
    # end
    # end
    # rescue StandardError => e
    #   render json: { errors: e.message }, status: :unprocessable_entity
  end
end
