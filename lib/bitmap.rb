# frozen_string_literal: true

# Bitmap is a pixelated image where each pixel is represented by a character
class Bitmap
  def initialize(size_x = 1, size_y = 1)
    @bitmap = Array.new(size_y) { 'O' * size_x }
  end

  def clear
    @bitmap.map! { |row| 'O' * row.length }
  end

  def color_pixel(pos_x, pos_y, color)
    @bitmap[(pos_x - 1)][pos_y - 1] = color
  end

  def render
    @bitmap.join("\n")
  end
end
