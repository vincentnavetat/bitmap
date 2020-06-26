# frozen_string_literal: true

# Bitmap is a pixelated image where each pixel is represented by a character
class Bitmap
  def initialize(size_x = 1, size_y = 1)
    size_x = size_x.to_i == 0 ? 1 : size_x.to_i
    size_y = size_y.to_i == 0 ? 1 : size_y.to_i

    @bitmap = Array.new(size_y, 'O' * size_x)
  end

  def render
    @bitmap.join("\n")
  end
end
