# frozen_string_literal: true

class Meetup
  include HTTParty
  base_uri 'api.meetup.com'
  attr_reader :options
  attr_accessor :name

  def initialize
    api_key  = ENV['MEETUP_API_KEY']
    @options = {
      query: {
        key: api_key,
        sign: 'true',
        desc: 'true',
        page: 10
      }
    }
  end

  def get_data(location)
    @location = location
    self.class.get("/find/groups?location=#{@location}", @options)
  end

  def events(location)
    if get_data(location).code.to_i == 200
      get_data(location).parsed_response
    else
      raise 'Error fetching data from Meetup API'
    end
  end
end
