require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    if params[:user_address]
        address = params[:user_address]
    else
        address = "the corner of foster and sheridan"
    end
    @url_safe_address = URI.encode(address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@url_safe_address+"&sensor=false"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    first = parsed_data["results"][0]
    geometry=first["geometry"]
    location = geometry["location"]
    @latitude = location["lat"]
    @longitude = location["lng"]

    # @latitude = 42.0538387
    # @longitude = -87.67721
    your_api_key = "ebf986b1100f445c9bc68065df22e878"

    url = "https://api.forecast.io/forecast/ebf986b1100f445c9bc68065df22e878/"+@latitude.to_s+","+@longitude.to_s
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["currently"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
