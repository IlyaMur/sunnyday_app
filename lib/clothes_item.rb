class ClothesItem
  attr_reader :name, :type, :min_temp, :max_temp

  def self.from_file(file_path)
    file_content = File.readlines(file_path, chomp: true)

    temperaturas = file_content[2].scan(/\-?\d+/).map(&:to_i)

    new(file_content[0], file_content[1], temperaturas[0], temperaturas[1])
  end

  def initialize(name, type, min_temp, max_temp)
    @name = name
    @type = type
    @min_temp = min_temp
    @max_temp = max_temp
  end

  def suitable_for_temperature?(temperature)
    temperature.between?(min_temp, max_temp)
  end

  def to_s
    "#{name} (#{type}) #{min_temp}..#{max_temp}"
  end
end
