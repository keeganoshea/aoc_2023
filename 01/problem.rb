class CollaborationValue
  def initialize(text)
    @text = text
  end

  def rows
    @text.split("\n")
  end

  def values
    rows.map do |row|
      nums = row.scan(/-?\d+/)
      string_nums = nums.join("")
      string_array = string_nums.split("")
      num = string_array.first + string_array.last
      num.to_i
    end
  end

  def sum
    values.sum
  end
end

INPUT = File.read(ARGV[0])

collab = CollaborationValue.new(INPUT)
puts collab.sum # 54450
# puts collab.values
