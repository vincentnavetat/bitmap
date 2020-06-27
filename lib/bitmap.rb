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
    # TODO: do not draw if pixel outside bitmap

    @bitmap[pos_y - 1][pos_x - 1] = color
  end

  def vertical_segment(pos_x, pos_y1, pos_y2, color)
    # TODO: do not draw if pixel outside bitmap

    segment = pos_y1 < pos_y2 ? (pos_y1..pos_y2) : (pos_y2..pos_y1)

    segment.each do |y|
      color_pixel(pos_x, y, color)
    end
  end

  def render
    @bitmap.join("\n")
  end
end
