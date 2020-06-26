# frozen_string_literal: true

require_relative 'bitmap'

# BitmapEditor generates a bitmap from a file containing recognised commands
class BitmapEditor
  def run(file)
    return puts 'Please provide correct file' if file.nil? || !File.exist?(file)

    return puts 'No command found' if File.zero?(file)

    read_file(file)
  end

  private

  def read_file(file)
    File.open(file).each do |line|
      line = line.chomp

      run_command(line)
    end
  end

  def run_command(line)
    case line[0]
    when 'I'
      @img = Bitmap.new(line[2].to_i, line[4].to_i)
    when 'S'
      show_bitmap
    else
      puts 'Unrecognised command :('
    end
  end

  def show_bitmap
    return puts 'There is no image' unless @img

    puts @img.render
  end
end
