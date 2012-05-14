require 'spec_helper'
describe 'car' do
  before do
    @world = Rover::World.new(5,5)
    @car = Rover::Car.new(:world => @world, :x=> 0, :y=> 0, :direction => :N)
  end
  it 'should turn to right' do
    @car.turn_right.should == :E
    @car.turn_right.should == :S
    @car.turn_right.should == :O
    @car.turn_right.should == :N
  end
  it 'should turn to left' do
    @car.turn_left.should == :O
    @car.turn_left.should == :S
    @car.turn_left.should == :E
    @car.turn_left.should == :N
  end
  it 'should move by one in the direction that is pointing' do
    @car.move
    @car.y.should == 1
    @car.move
    @car.y.should == 2
    @car.turn_right
    @car.move
    @car.x.should == 1
    @car.y.should == 2
    @car.turn_left
    @car.move
    @car.y.should == 3
    @car.x.should == 1
  end
end