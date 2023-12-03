class CollaborationValue
  def initialize(text)
    @text = text
  end

  def rows
    @text.split("\n")
  end

  def values
    word_values.map do |row|
      string_array = row.split("")
      num = string_array.first + string_array.last
      num.to_i
    end
  end

  def word_values
    rows.map do |row|
      words = row.scan(/(?=(0|1|2|3|4|5|6|7|8|9|0|one|two|three|four|five|six|seven|eight|nine))/)
      string = words.join("")
      string.gsub("one", "1").
        gsub("two", "2").
        gsub("three", "3").
        gsub("four", "4").
        gsub("five", "5").
        gsub("six", "6").
        gsub("seven", "7").
        gsub("eight", "8").
        gsub("nine", "9")
    end
  end

  def sum
    values.sum
  end
end

INPUT = File.read(ARGV[0])

collab = CollaborationValue.new(INPUT)
puts "Try: #{collab.sum}"
# puts collab.values

# problem 1 solution
# 54450

# problem 2 attempts
# 54258
# 54265 correct answer




