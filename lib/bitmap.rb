# frozen_string_literal: true

# Bitmap is a pixalated image where pixels are represented by characters
class Bitmap
  def initialize(size_x, size_y)
    @bitmap = Array.new(size_y, 'O' * size_x)
  end

  def show
    @bitmap.each do |line|
      puts line
    end
  end
end
