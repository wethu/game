#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require_relative 'player'
require_relative 'hit_box'
require_relative 'boundary'
require_relative 'builder'
Bundler.require(:default)

window = get(:window)

green_l = Rectangle.new
green_l.x = 0
green_l.y = 470
green_l.width = 310
green_l.height = 10
green_l.color = "green"

green_r = Rectangle.new
green_r.x = 330
green_r.y = 470
green_r.width = 310
green_r.height = 10
green_r.color = "green"



bar = Builder.new(:rect).build(x: 50, y: 430, width: 100, height: 5)
platform = HitBox.new(bar)

bar2 = Builder.new(:rect).build(x: 100, y: 390, width: 100, height: 5)
platform_2 = HitBox.new(bar2)

bar3 = Builder.new(:rect).build(x: 150, y: 340, width: 100, height: 5)
platform_3 = HitBox.new(bar3)

red = Rectangle.new
red.x = 15
red.y = 400
red.width = 10
red.height = 20
red.color = 'red'

boundary = Boundary.new(window)
land_1 = HitBox.new(green_l)
land_2 = HitBox.new(green_r)

player = HitBox.new(red)
m = Player.new(player)

game_tick = -> {
  land_1.collision(player) { |i| m.stop }
  land_2.collision(player) { |i| m.stop }
  platform.collision(player) { |i| m.stop }
  platform_2.collision(player) { |i| m.stop }
  platform_3.collision(player) { |i| m.stop }

  m.stop if (player.x < 0) || ((player.x + player.width) > boundary.width)
  m.stop if (player.y < 0)
  m.die  if (player.y > boundary.height)
  if m.dead? && m.y > 600
    m.x = 15
    m.y = 400
    m.revive!
  end

}

on :key do |input|
  m.move(input)
  game_tick.call
end

update do
  m.fall
  game_tick.call
end
show
