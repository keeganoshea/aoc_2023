class Competition
  attr_reader :races
  def initialize(data, multi: true)
    @races = create_races(data, multi)
  end

  def create_races(data, multi)
    if multi
      time = data.split("\n").first.scan(/-?\d+/)
      distance = data.split("\n").last.scan(/-?\d+/)
      time_distance = time.zip(distance)
      time_distance.map do |td|
        BoatRace.new(td.first.to_i, td.last.to_i)
      end
    else
      time = data.split("\n").first.split(":").last.gsub(" ", "")
      distance = data.split("\n").last.split(":").last.gsub(" ", "")
      [BoatRace.new(time.to_i, distance.to_i)]
    end
  end

  def count_of_race_wins
    races.first.count_of_winning_races
  end

  def product_of_winning_races
    races.map do |race|
      race.count_of_winning_races
    end.inject(:*)
  end
end

class BoatRace
  attr_accessor :duration, :record_distance, :starting_distance
  def initialize(duration, record_distance)
    @duration = duration
    @record_distance = record_distance
    @starting_distance = 0
  end

  def count_of_winning_races
    winning_charge_times.count
  end

  def winning_charge_times
    all_distance_options.select { |opt| opt > record_distance }
  end

  def all_distance_options
    hold_times = (0..duration).to_a
    hold_times.map do |hold_time|
      distance_on_charge(hold_time)
    end
  end

  def distance_on_charge(hold_time)
    speed = hold_time
    travel_duration = duration - hold_time
    speed * travel_duration
  end
end


input = File.read(ARGV[0])
competition_1 = Competition.new(input)
competition_2 = Competition.new(input, multi: false)
puts "Part 1: #{competition_1.product_of_winning_races}"
puts "Part 2: #{competition_2.count_of_race_wins}"
