require_relative 'bitmap'

class BitmapEditor
  attr_reader :bitmap

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
      L: :paint_pixel,
      V: :vertical_segment,
      H: :horizontal_segment,
      F: :fill,
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

    @bitmap = Bitmap.new(size_x, size_y)
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
    @bitmap.clear
  end

  def valid_params(line, format)
    unless format.match? line
      @warnings << "This command was ignored because of invalid parameters: #{line}"
      return
    end

    line.scan(format).first
  end

  def paint_pixel(line)
    params = valid_params(line, /L (\d+) (\d+) ([A-Z])/)

    @bitmap.paint_pixel(params[0].to_i, params[1].to_i, params[2]) if params
  end

  def vertical_segment(line)
    params = valid_params(line, /V (\d+) (\d+) (\d+) ([A-Z])/)

    @bitmap.vertical_segment(params[0].to_i, params[1].to_i, params[2].to_i, params[3]) if params
  end

  def horizontal_segment(line)
    params = valid_params(line, /H (\d+) (\d+) (\d+) ([A-Z])/)

    @bitmap.horizontal_segment(params[0].to_i, params[1].to_i, params[2].to_i, params[3]) if params
  end

  def fill(line)
    params = valid_params(line, /F (\d+) (\d+) ([A-Z])/)

    @bitmap.fill(params[0].to_i, params[1].to_i, params[2]) if params
  end

  def show_bitmap(_line)
    return puts 'There is no image' unless @bitmap

    puts @bitmap.render
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
