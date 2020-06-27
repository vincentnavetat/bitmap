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
    return if pos_y > @bitmap.length
    return if pos_x > @bitmap.first.length

    @bitmap[pos_y - 1][pos_x - 1] = color
  end

  def vertical_segment(pos_x, pos_y1, pos_y2, color)
    segment_values(pos_y1, pos_y2).each do |pos_y|
      color_pixel(pos_x, pos_y, color)
    end
  end

  def horizontal_segment(pos_x1, pos_x2, pos_y, color)
    segment_values(pos_x1, pos_x2).each do |pos_x|
      color_pixel(pos_x, pos_y, color)
    end
  end

  def render
    @bitmap.join("\n")
  end

  private

  def segment_values(first, second)
    first < second ? (first..second) : (second..first)
  end
end
