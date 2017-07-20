require 'active_support'
require 'active_support/core_ext'
class Player
  def initialize(object)
    @jump_count = 0
    @speed = 1
    @jump_speed = 4
    @object = object
    @inputs = []
  end

  delegate :x, :x=, :y, :y=, :height, :width, :width=, :height=, to: :@object

  ACTIONS = {
    held: {
      "a" => ->(object) {
        object.x -= object.speed
      },
      "d" => ->(object) {
        object.x += object.speed
      },
      "space" => ->(object) { object.jump },
      "left shift" => ->(o) { o.run_speed! }
    },
    up: {
      "s" => ->(o) {
        o.height = 20
        o.y -= 10
      },
      "left shift" => -> (o) { o.walk_speed! }
    },
    down: {
      "s" => ->(object) {
        object.height = 10
      },
    }
  }.freeze

  def move(key)
    return if dead?
    @last_position = { x: x, y: y }
    ACTIONS[key.type].fetch(key.key) { return }.call(self)
  end

  attr_reader :last_position, :speed

  def stop
    @jump_count = 0
    return if @dead
    self.x = last_position[:x]
    self.y = last_position[:y]
  end

  def fall
    @last_position = { x: x, y: y }
    self.y += 2
  end

  def jump
    @jump_count += 1
    return if @jump_count >= 15
    self.y -= @jump_speed
  end

  def run_speed!
    @speed = 3
  end

  def die
    return if dead?
    self.y -= 100
    self.x -= 15
    self.width = 30
    self.height = 60
    @dead = true
  end

  def dead?
    !!@dead
  end

  def revive!
    return unless dead?
    self.width = 10
    self.height = 20
    @dead = false
  end

  def walk_speed!
    @speed = 1
  end
end
