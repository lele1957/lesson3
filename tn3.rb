class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def type_amount(type)
    @trains.count { |train| train.type == type }
  end
end
class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station,last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
class Train
  attr_reader :speed, :type, :cars_amount

  def initialize(number, type, cars_amount)
    @number = number
    @type = type
    @cars_amount = cars_amount
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def speed_up(value)
    @speed += value
  end

  def current_speed
    @current_speed = @speed
  end

  def add_car
    @cars_amount += 1 if @speed == 0
  end

  def drop_car
    @cars_amount -= 1 if @speed == 0 && @cars_amount > 0
  end

  def set_route=(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def station_forward
    return unless next_station
      current_station.train_departure(self)
      @current_station_index += 1
      current_station.add_train(self)
    end
  end

  def station_backward
      return unless previous_station
      current_station.train_departure(self)
      @current_station_index += 1
      current_station.add_train(self)
    end
  end

  def current_station
    @route.stations[@station]
  end

  def next_station
    @route.stations[@station + 1] if current_station != @route.stations.last
  end

  def previous_station
    @route.stations[@station - 1] if current_station != @route.stations.first
  end
end