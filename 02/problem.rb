class CubeConundrum
  attr_accessor :games,
                :red_cubes_loaded,
                :blue_cubes_loaded,
                :green_cubes_loaded,
                :impossible_games

  def initialize(games, red_cubes_loaded: 0, green_cubes_loaded: 0, blue_cubes_loaded: 0)
    @games = games.split("\n").map do |game|
      Game.new(game)
    end
    @red_cubes_loaded = red_cubes_loaded
    @green_cubes_loaded = green_cubes_loaded
    @blue_cubes_loaded = blue_cubes_loaded
  end

  def possible_games_max
    impossible_games = check_game_possiblity_max.uniq
    games - impossible_games
  end

  def sum_possible_game_ids
    possible_games_max.map(&:id).sum
  end

  def check_game_possiblity_max
    impossible_games = []
    games.each do |game|
      if game.set.red_cubes_max > red_cubes_loaded
        impossible_games << game
      end
      if game.set.green_cubes_max > green_cubes_loaded
        impossible_games << game
      end
      if game.set.blue_cubes_max > blue_cubes_loaded
        impossible_games << game
      end
    end
    impossible_games
  end

  def power_of_sets
    check_game_possiblity_min.sum
  end

  def check_game_possiblity_min
    games.map do |game|
      [
        game.set.red_cubes_max,
        game.set.green_cubes_max,
        game.set.blue_cubes_max
      ].inject(:*)
    end
  end
end

class Game
  attr_accessor :set, :name, :id
  def initialize(game)
    @name = game.delete(" \t\r\n").split(":").first
    @id = name.delete("Game").to_i
    @set = Set.new(game.delete(" \t\r\n").split(":").last)
  end
end

class Set
  attr_reader :groups
  def initialize(set)
    @sets = set.split(";")
    @groups = @sets.map do |set|
      set.split(",")
    end.flatten
  end

  def cubes_max(color)
    nums = []
    groups.each do |play|
      if play.scan(/#{color}/).any?
        nums << play.scan(/-?\d+/).first.to_i
      end
    end
    nums.max
  end

  def red_cubes_max
    cubes_max("red")
  end

  def green_cubes_max
    cubes_max("green")
  end

  def blue_cubes_max
    cubes_max("blue")
  end
end

games = File.read(ARGV[0])
game = CubeConundrum.new(games, red_cubes_loaded: 12, green_cubes_loaded: 13, blue_cubes_loaded: 14)
puts "Part 1: #{game.sum_possible_game_ids}"
# part 2
puts "Part 2: #{game.power_of_sets}"


