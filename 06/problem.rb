class Competition
  attr_reader :races
  def initialize(data)
    @races = create_races(data)
  end

  def create_races(data)
    time = data.split("\n").first.scan(/-?\d+/)
    distance = data.split("\n").last.scan(/-?\d+/)
    time_distance = time.zip(distance)
    time_distance.map do |td|
      BoatRace.new(td.first.to_i, td.last.to_i)
    end
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
competition = Competition.new(input)
puts competition.product_of_winning_races
