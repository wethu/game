class Boundary
  def initialize(window)
    @window = window
  end

  def width
    @window.instance_variable_get(:@width)
  end

  def height
    @window.instance_variable_get(:@height)
  end


  # def x1
  #   0
  # end

  # def x2
  #   @window.instance_variable_get(:@width)
  # end

  # def x3
  #   @window.instance_variable_get(:@width)
  # end

  # def x4
  #   0
  # end

  # def y1
  #   0
  # end

  # def y2
  #   0
  # end

  # def y3
  #   @window.instance_variable_get(:@height)
  # end

  # def y4
  #   @window.instance_variable_get(:@height)
  # end
end
