require 'spec_helper'
describe 'world' do
  before do
    @world = Rover::World.new(5,5)
    @car = Rover::Car.new(:world => @world, :x=> 0, :y=> 0)
  end
  it 'should move a car by n on X' do
    @world.move_x @car, 1
    @car.x.should == 1
    # the world is round!!! did you know that?
    @world.move_x @car, -2
    @car.x.should == 4
  end
  it 'should not be able to move a car by n on X if another car is there' do
    other_car = Rover::Car.new(:world => @world, :x=> 1, :y=> 0)
    lambda{@world.move_x @car, 1}.should raise_error("another car is there, so sorry...")
  end
  it 'should move a object by n on Y' do
    @world.move_y @car, 1
    @car.y.should == 1
    # the world is round!!! did you know that?
    @world.move_y @car, -2
    @car.y.should == 4
  end
  it 'should not be able to move a car by n on Y  if another car is there' do
    other_car = Rover::Car.new(:world => @world, :x=> 0, :y=> 1)
    lambda{@world.move_y @car, 1}.should raise_error("another car is there, so sorry...")
  end
  it 'should raise and error if a car is the position during initialization' do
    lambda{Rover::Car.new(:world => @world, :x=> 0, :y=> 0)}.should raise_error("another car is there, so sorry...")
  end
end