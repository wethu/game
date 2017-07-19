require 'rubygems'
require 'bundler/setup'
require_relative 'player'
require_relative 'hit_box'

Bundler.require(:default)

green = Rectangle.new
green.x = 0
green.y = 470
green.width = 640
green.height = 10
green.color = "green"

red = Rectangle.new
red.x = 15
red.y = 400
red.width = 10
red.height = 20
red.color = 'red'

land = HitBox.new(green)
player = HitBox.new(red)
m = Player.new(player)

@speed = 1
on :key do |input|
  m.move(input.key, @speed)
  land.collision(player) do |impact|
    m.stop
  end
end

update do
  m.move('s', 2)
  land.collision(player) do |impact|
    m.stop
  end
end
show
