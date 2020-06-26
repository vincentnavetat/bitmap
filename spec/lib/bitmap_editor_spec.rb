# frozen_string_literal: true

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
end
