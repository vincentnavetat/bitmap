require 'bitmap_editor'

RSpec.describe BitmapEditor do
  context 'with wrong file path' do
    it 'returns an error message asking for a correct path' do
      expect do
        BitmapEditor.new.run('wrong/path/file.txt')
      end.to output("Please provide correct file\n").to_stdout
    end
  end

  context 'with empty file' do
    it 'returns an error message indicating no command found' do
      expect do
        BitmapEditor.new.run('examples/empty.txt')
      end.to output("No command found\n").to_stdout
    end
  end

  context 'with file showing no initialised bitmaps' do
    it 'returns an error message indicating no command found' do
      expect do
        BitmapEditor.new.run('examples/no_bitmap.txt')
      end.to output("There is no image\n").to_stdout
    end
  end

  context 'with file showing initial white bitmap' do
    it 'shows a white bitmap of 3 x 2' do
      expect do
        BitmapEditor.new.run('examples/init.txt')
      end.to output("OOO\nOOO\n").to_stdout
    end
  end

  context 'with bitmap bigger than 250 limits' do
    it 'returns an error message indicating image is too big' do
      expect do
        BitmapEditor.new.run('examples/too_big.txt')
      end.to output(/The image was truncated because the size X given was larger than 250/).to_stdout
    end
  end

  context 'using L command' do
    it 'shows a white bitmap with one pixel of color As' do
      expect do
        BitmapEditor.new.run('examples/color_pixel.txt')
      end.to output("OOO\nAOO\n").to_stdout
    end
  end

  context 'using C command on a bitmap with a pixel of different color' do
    it 'shows a white bitmap of 3 x 2' do
      expect do
        BitmapEditor.new.run('examples/clear.txt')
      end.to output("OOO\nOOO\n").to_stdout
    end
  end

  context 'file has unknown command' do
    it 'shows a warning that file has unknown command' do
      expect do
        BitmapEditor.new.run('examples/unknown_command.txt')
      end.to output(/Unrecognised command/).to_stdout
    end
  end

  context 'file has all possible instructions' do
    it 'shows bitmap as expected' do
      expect do
        BitmapEditor.new.run('examples/demo.txt')
      end.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout
    end
  end
end
