#require "rover/version"

module Rover
  class World
    def initialize columns, rows
      @my_word = Array.new(rows) { Array.new(columns) }
    end
    def initialize_car rover
      raise "another car is there, so sorry..." if @my_word[rover.x][rover.y]
      @my_word[rover.x][rover.y] = rover
    end
    def move_up car
      move_x car, -1
    end
    def move_down car
      move_x car, 1
    end
    def move_right car
      move_y car, 1
    end
    def move_left car
      move_y car, -1
    end
    def move_x car, by
      new_x =  (car.x + by) % @my_word.count
      raise "another car is there, so sorry..." if @my_word[new_x][car.y] &&  @my_word[new_x][car.y]!=car
      @my_word[new_x][car.y] = car
      @my_word[car.x][car.y] = nil
      car.x = new_x
    end
    def move_y car, by
      new_y = (car.y + by) % @my_word[0].count
      raise "another car is there, so sorry..." if @my_word[car.x][new_y] &&  @my_word[car.x][new_y]!=car
      @my_word[car.x][new_y] = car
      @my_word[car.x][car.y] = nil
      car.y = new_y
    end
    def to_s
      world_representation = ''
      @my_word.each do |row|
        row.each do |column|
          world_representation += (column.nil? ? '.' : 'c')
        end
        world_representation+= "\n"
      end
      world_representation
    end
  end
  class Car
    attr_accessor :x, :y, :direction
    def initialize conf
      @world = conf[:world]
      @x = conf[:x]
      @y = conf[:y]
      @direction = conf[:direction]
      @world.initialize_car(self)
      @cardinals_to_right = {:N => :E, :E => :S, :S => :O, :O => :N}
      @cardinals_to_left = {:N => :O, :O => :S, :S => :E, :E => :N}
    end
    def move
      case @direction
      when :N then @world.move_right self
      when :S then @world.move_left self
      when :E then @world.move_down self
      when :O then @world.move_up self
      end
    end
    def turn_right
      @direction = @cardinals_to_right[@direction]
    end
    def turn_left
      @direction = @cardinals_to_left[@direction]
    end
    def turn to
      case to
      when :L then self.turn_left
      when :R then self.turn_right
      end
    end
    def action letter
      ([:L, :R].include?(letter))? self.turn(letter) : move
    end
  end
  def self.runner(input_file, output_file)
    input = open(input_file).readlines
    output = File.open(output_file, 'w')
    matrix_sizes = input.shift.strip.split(' ').map{|c|c.to_i + 1}
    the_world = Rover::World.new(*matrix_sizes)
    until input.count == 0
      car_conf = input.shift.strip.split(' ')
      actions_conf = input.shift.strip.split(//).map{|x|x.to_sym}
      car = Rover::Car.new(:world => the_world,
                           :x => car_conf.shift.to_i,
                           :y => car_conf.shift.to_i,
                           :direction=> car_conf.shift.to_sym)
      actions_conf.each{|action|car.action(action)}
      output.puts "#{car.x} #{car.y} #{car.direction}"
    end
    output.close
  end
end