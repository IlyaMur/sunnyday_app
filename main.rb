require_relative 'lib/wardrobe'
require_relative 'lib/temperature_getter'
require 'dotenv/load'

OPENWEATHERMAP_API_KEY = ENV['OPENWEATHERMAP_API_KEY'].freeze

wardrobe = Wardrobe.from_dir(File.join(__dir__, 'data'))

user_temp = TemperatureGetter.call(api_key: OPENWEATHERMAP_API_KEY)

puts "Предсказываю погоду... #{user_temp.to_i} гр."

suitable_wardrobe = wardrobe.for_weather(user_temp)

wardrobe_for_user =
  Wardrobe.new(
    suitable_wardrobe.types.map { |type| suitable_wardrobe.for_type(type).sample }
  )

puts 'Предлагаю сегодня надеть:'
puts wardrobe_for_user
