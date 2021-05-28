require_relative 'clothes_item'

class Wardrobe
  def self.from_dir(dir_path)
    files = Dir[File.join(dir_path, '*.txt')]

    clothes = files.map { |file| ClothesItem.from_file(file) }

    new(clothes)
  end

  def initialize(clothes)
    @clothes = clothes
  end

  def for_weather(temperature)
    suitable_for_temperature =
      @clothes.select { |item| item.suitable_for_temperature?(temperature) }

    self.class.new(suitable_for_temperature)
  end

  def for_type(type)
    suitable_for_type =
      @clothes.select { |item| item.type == type }

    self.class.new(suitable_for_type)
  end

  def types
    @clothes.map(&:type).uniq
  end

  def sample
    @clothes.sample
  end

  def to_s
    @clothes.join("\n")
  end
end
