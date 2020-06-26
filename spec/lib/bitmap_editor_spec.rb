# frozen_string_literal: true

require 'bitmap_editor'

RSpec.describe BitmapEditor do
  context 'with wrong file path' do
    it 'returns an error message' do
      expect do
        BitmapEditor.new.run('wrong/path/file.txt')
      end.to output("please provide correct file\n").to_stdout
    end
  end
end
