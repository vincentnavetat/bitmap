# frozen_string_literal: true

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
      case line
      when 'S'
        puts 'There is no image'
      else
        puts 'Unrecognised command :('
      end
    end
  end
end
