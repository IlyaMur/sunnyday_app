require 'httparty'
require 'geocoder'

class TemperatureGetter
  OPENWEATHERMAP_API_URL = 'https://api.openweathermap.org/data/2.5/weather'.freeze
  MY_IP_API_URL = 'https://api.my-ip.io/ip.json'.freeze

  def self.call(api_key:)
    new(api_key).call
  end

  def initialize(api_key)
    @api_key = api_key
  end

  def call
    @user_temp ||= HTTParty.get(OPENWEATHERMAP_API_URL, query: open_weather_map_params).parsed_response['main']['temp'].to_f
  end

  private

  attr_reader :api_key

  def ip_address
    @ip_address ||= HTTParty.get(MY_IP_API_URL).parsed_response['ip']
  end

  def coordinates
    @coordinates ||= Geocoder.search(ip_address).first.coordinates
  end

  def lattitude
    coordinates.first
  end

  def longitude
    coordinates.last
  end

  def open_weather_map_params
    {
      lat: lattitude,
      lon: longitude,
      appid: api_key,
      units: 'metric'
    }
  end
end
