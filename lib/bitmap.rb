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

  def color_pixel(pos_x, pos_y, color)
    return if pos_y > @pixels.length
    return if pos_x > @pixels.first.length

    @pixels[pos_y - 1][pos_x - 1] = color.upcase
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


  def fill(pos_x, pos_y, color)
    matching_color = pixel_color(pos_x, pos_y)
    pixels_to_fill = [[pos_x, pos_y]]

    while pixels_to_fill.length > 0 do
      fill_now = pixels_to_fill.shift

      color_pixel(fill_now[0], fill_now[1], color)

      pixels_to_fill = add_neighboor_pixels(pixels_to_fill, fill_now, matching_color)
    end
  end

  def render
    @pixels.join("\n")
  end

  private

  WHITE = 'O'.freeze

  def segment_values(first, second)
    first < second ? (first..second) : (second..first)
  end

  def pixel_color(pos_x, pos_y)
    @pixels[pos_x - 1][pos_y - 1]
  end

  def add_neighboor_pixels(pixel_array, fill_now, matching_color)
    # up
    pixel_array << [fill_now[0], fill_now[1] - 1] if pixel_color(fill_now[0], fill_now[1] - 1) == matching_color

    # right
    pixel_array << [fill_now[0] + 1, fill_now[1]] if pixel_color(fill_now[0] + 1, fill_now[1]) == matching_color

    # bottom
    pixel_array << [fill_now[0], fill_now[1] + 1] if pixel_color(fill_now[0], fill_now[1] + 1) == matching_color

    # left
    pixel_array << [fill_now[0] - 1, fill_now[1]] if pixel_color(fill_now[0] - 1, fill_now[1]) == matching_color

    pixel_array
  end
end
