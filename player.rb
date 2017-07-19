class Player
  def initialize(object)
    @jump_count = 0
    @object = object
  end

  KEY_BINDINGS = {
    # "w" => :up,
    "s" => :down,
    "a" => :left,
    "d" => :right,
    "space" => :jump
  }.freeze

  MOVEMENTS = {
    up:    ->(object, speed) { object.up(speed) },
    down:  ->(object, speed) { object.down(speed) },
    left:  ->(object, speed) { object.left(speed) },
    right: ->(object, speed) { object.right(speed) },
    jump:  ->(object, _)     { object.jump }
  }.freeze

  def move(key, speed)
    direction = KEY_BINDINGS.fetch(key) { return }
    @last_position = { x: @object.x, y: @object.y }
    MOVEMENTS.fetch(direction, ->(*){}).call(self, speed)
  end

  attr_reader :last_position

  def stop
    @jump_count = 0
    @object.x = last_position[:x]
    @object.y = last_position[:y]
  end

  def jump
    @jump_count += 1
    return if @jump_count >= 15
    @object.y -= 4
  end

  def up(speed = 1)
    @object.y -= speed
  end

  def down(speed = 1)
    @object.y += speed
  end

  def left(speed = 1)
    @object.x -= speed
  end

  def right(speed = 1)
    @object.x += speed
  end

end
