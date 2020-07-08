class Bitmap
  attr_reader :pixels, :width, :height

  def initialize(width = 1, height = 1)
    @width = width.to_i
    @height = height.to_i
    @pixels = Array.new(@height)
    clear
  end

  def clear
    @pixels.map! { |_row| WHITE * @width }
  end

  def paint_pixel(pos_x, pos_y, color)
    return if pos_y > @pixels.length
    return if pos_x > @pixels.first.length

    @pixels[pos_y - 1][pos_x - 1] = color.upcase
  end

  def vertical_segment(pos_x, pos_y1, pos_y2, color)
    segment_values(pos_y1, pos_y2).each do |pos_y|
      paint_pixel(pos_x, pos_y, color)
    end
  end

  def horizontal_segment(pos_x1, pos_x2, pos_y, color)
    segment_values(pos_x1, pos_x2).each do |pos_x|
      paint_pixel(pos_x, pos_y, color)
    end
  end

  def fill(pos_x, pos_y, color)
    matching_color = pixel_color(pos_x, pos_y)
    pixels_to_fill = [[pos_x, pos_y]]

    until pixels_to_fill.empty?
      pixel = pixels_to_fill.shift

      paint_pixel(pixel[0], pixel[1], color)

      pixels_to_fill = add_matching_neighboring_pixels(pixels_to_fill, pixel, matching_color)
    end
  end

  def render
    @pixels.join("\n")
  end

  private

  WHITE = 'O'.freeze

  def pixel_color(pos_x, pos_y)
    @pixels[pos_y - 1][pos_x - 1]
  end

  def segment_values(first, second)
    first < second ? (first..second) : (second..first)
  end

  def add_matching_neighboring_pixels(matching_pixels, pixel, matching_color)
    # up
    matching_pixels << [pixel[0], pixel[1] - 1] if pixel_color(pixel[0], pixel[1] - 1) == matching_color

    # right
    matching_pixels << [pixel[0] + 1, pixel[1]] if pixel_color(pixel[0] + 1, pixel[1]) == matching_color

    # bottom
    matching_pixels << [pixel[0], pixel[1] + 1] if pixel_color(pixel[0], pixel[1] + 1) == matching_color

    # left
    matching_pixels << [pixel[0] - 1, pixel[1]] if pixel_color(pixel[0] - 1, pixel[1]) == matching_color

    matching_pixels.uniq
  end
end
