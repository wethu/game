require 'ruby2d'
class Builder

  SHAPES = {
    rect:   Rectangle,
    square: Square
  }.freeze

  def initialize(shape)
    @shape = SHAPES.fetch(shape).new
  end

  def build(x:, y:, width:, height:, color: nil)
    @shape.tap do |shape|
      shape.x = x
      shape.y = y
      shape.width = width
      shape.height = height
      shape.color = (color || random_color)
    end
  end

  private

  def random_color
    %w(blue brown yellow orange purple).sample
  end
end
