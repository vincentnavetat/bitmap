class Coords
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def clean_up(min, max)
    @x = clean_up_coord(x, min, max)
    @y = clean_up_coord(y, min, max)
  end

  private

  def clean_up_coord(v, min, max)
    v = [v, min].max
    [v, max].min
  end
end
