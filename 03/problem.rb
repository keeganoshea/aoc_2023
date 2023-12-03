class GearRatio
  attr_reader :x_max, :y_max, :rows
  def initialize(input)
    @rows = input.split("\n")
    @x_max = rows.first.length
    @y_max = rows.length
  end

  def run
    map = part_pieces.dup
    mark_the_blasts(map)
    marked = map.flatten.join.scan(/-?\d+/)
    original = rows.join.scan(/-?\d+/)
    remaining = original & marked
    removed = original - remaining
    removed.map(&:to_i).sum
  end

  # create a 2d array that we can mark off
  def part_pieces
    rows.map do |row|
      row.split("")
    end
  end

  def mark_the_blasts(map)
    min = 0
    y = 0
    part_pieces.each do |part|
      puts "part_piece: #{part}"
      part.each_with_index do |p, idx|
        if p.match?(/[^0-9.]/)
          # top left
          map[y-1][idx-1] = "X" if y > min && idx > min
          # top middle
          map[y-1][idx] = "X"  if y > min
          # top right
          map[y-1][idx+1] = "X" if y > min && idx < x_max
          # middle left
          map[y][idx-1] = "X" if y > min && idx > min
          # middle middle
          map[y][idx] = "X"
          # middle right
          map[y][idx+1] = "X" if y > min && idx < x_max
          # bottom left
          map[y+1][idx-1] = "X" if y < y_max && idx > min
          # bottom middle
          map[y+1][idx] = "X" if y < y_max
          # bottom right
          map[y+1][idx+1] = "X" if y < y_max && idx < x_max
        end
      end
      y += 1
    end
  end
end

input = File.read(ARGV[0])
engine = GearRatio.new(input)
puts "Part 1: #{engine.run}"
# attempts
# 437798 - is too low
