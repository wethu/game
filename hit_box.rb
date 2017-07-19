class HitBox < SimpleDelegator
  def collision(object)
    impact = {
      top:    (top    & object.bottom),
      bottom: (bottom & object.top),
      left:   (left   & object.right),
      right:  (right  & object.left)
    }
    return unless impact[:top].any?  || impact[:bottom].any?
    return unless impact[:left].any? || impact[:right].any?
    yield(impact)
  end

  def top
    (x1..x2).to_a
  end

  def right
    (y2..y3).to_a
  end

  def bottom
    (x4..x3).to_a
  end

  def left
    (y1..y4).to_a
  end
end
