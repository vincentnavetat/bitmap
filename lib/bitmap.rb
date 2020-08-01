require_relative 'coords'

class Bitmap
  attr_reader :pixels, :size

  def initialize(width = 1, height = 1)
    # @width = width.to_i
    # @height = height.to_i
    @size = Coords.new(width, height)
    @pixels = Array.new(size.y)
    clear
  end

  def clear
    pixels.map! { |_row| WHITE * size.x }
  end

  def paint_pixel(x, y, color)
    pixels[y - 1][x - 1] = color.upcase if pixel_exists?(x, y)
  end

  def vertical_segment(x, y1, y2, color)
    segment_values(y1, y2).each do |y|
      paint_pixel(x, y, color)
    end
  end

  def horizontal_segment(x1, x2, y, color)
    segment_values(x1, x2).each do |x|
      paint_pixel(x, y, color)
    end
  end

  def fill(x, y, color)
    matching_color = pixel_color(x, y)
    pixels_to_fill = [[x, y]]

    until pixels_to_fill.empty?
      pixel = pixels_to_fill.shift

      paint_pixel(pixel[0], pixel[1], color)

      pixels_to_fill = add_matching_neighboring_pixels(pixels_to_fill, pixel, matching_color)
    end
  end

  def render
    pixels.join("\n")
  end

  private

  WHITE = 'O'.freeze

  def pixel_exists?(x, y)
    x.positive? && x <= size.x && y.positive? && y <= size.y
  end

  def pixel_color(x, y)
    pixels[y - 1][x - 1]
  end

  def pixel_match?(x, y, color)
    pixel_exists?(x, y) && pixel_color(x, y) == color
  end

  def segment_values(first, second)
    first, second = [first, second].sort

    (first..second)
  end

  def add_matching_pixel(matching_pixels, x, y, matching_color)
    matching_pixels << [x, y] if pixel_match?(x, y, matching_color)
  end

  def add_matching_neighboring_pixels(matching_pixels, pixel, matching_color)
    # up
    add_matching_pixel(matching_pixels, pixel[0], pixel[1] - 1, matching_color)

    # right
    add_matching_pixel(matching_pixels, pixel[0] + 1, pixel[1], matching_color)

    # bottom
    add_matching_pixel(matching_pixels, pixel[0], pixel[1] + 1, matching_color)

    # left
    add_matching_pixel(matching_pixels, pixel[0] - 1, pixel[1], matching_color)

    matching_pixels.uniq
  end
end
