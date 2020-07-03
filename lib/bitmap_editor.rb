require_relative 'bitmap'

# BitmapEditor generates a bitmap from a file containing recognised commands
class BitmapEditor
  def initialize
    @warnings = []
  end

  def run(file, options = '')
    return puts 'Please provide correct file' if file.nil? || !File.exist?(file)
    return puts 'No command found' if File.zero?(file)

    read_file(file)

    show_warnings if show_warnings?(options)
  end

  private

  MIN_SIZE = 1
  MAX_SIZE = 250

  COMMANDS =
    {
      I: :init,
      C: :clear,
      L: :color_pixel,
      V: :vertical_segment,
      H: :horizontal_segment,
      S: :show_bitmap
    }.freeze

  def read_file(file)
    File.open(file).each do |line|
      line = line.chomp

      run_command(line)
    end
  end

  def run_command(line)
    key = line[0].to_sym

    if COMMANDS.key?(key)
      send COMMANDS[key], line
    else
      @warnings << "Unrecognised command: #{line}"
    end
  end

  def init(line)
    args = line.split(' ')

    size_x = clean_size(args[1], 'X')
    size_y = clean_size(args[2], 'Y')

    @img = Bitmap.new(size_x, size_y)
  end

  def clean_size(size, name)
    size = size.to_i < 1 ? MIN_SIZE : size.to_i

    if size > MAX_SIZE
      size = MAX_SIZE

      @warnings << "The image was truncated because the size #{name} given was larger than #{MAX_SIZE}"
    end

    size
  end

  def clear(_line)
    @img.clear
  end

  def color_pixel(line)
    args = line.split(' ')

    x = args[1].to_i
    y = args[2].to_i
    color = args[3]

    @img.color_pixel(x, y, color)
  end

  def vertical_segment(line)
    args = line.split(' ')

    x = args[1].to_i
    y1 = args[2].to_i
    y2 = args[3].to_i
    color = args[4]

    @img.vertical_segment(x, y1, y2, color)
  end

  def horizontal_segment(line)
    args = line.split(' ')

    x1 = args[1].to_i
    x2 = args[2].to_i
    y = args[3].to_i
    color = args[4]

    @img.horizontal_segment(x1, x2, y, color)
  end

  def show_bitmap(_line)
    return puts 'There is no image' unless @img

    puts @img.render
  end

  def show_warnings
    puts "\nWarnings:\n" if @warnings.any?

    @warnings.each do |warning|
      puts " • #{warning}\n"
    end
  end

  def show_warnings?(options)
    /--show-warnings/.match?(options)
  end
end
