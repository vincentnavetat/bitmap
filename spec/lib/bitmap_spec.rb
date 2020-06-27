# frozen_string_literal: true

require 'bitmap'

RSpec.describe Bitmap do
  let(:empty_bitmap) { Bitmap.new }
  let(:bitmap) { Bitmap.new(3, 2) }
  let(:large_bitmap) { Bitmap.new(6, 5) }

  describe '#color_pixel' do
    context 'for a bitmap with white pixels' do
      it 'colors the selected pixel' do
        bitmap.color_pixel(3, 2, 'W')
        expect(bitmap.render).to eq("OOO\nOOW")
      end
    end
  end

  describe '#clear' do
    context 'for a white bitmap with one pixel of color W' do
      it 'renders a white 3x2 bitmap' do
        bitmap.color_pixel(2, 2, 'W')
        bitmap.clear
        expect(bitmap.render).to eq("OOO\nOOO")
      end
    end
  end

  describe '#vertical_segment' do
    context 'for a vertical segmented (top to bottom)' do
      it 'renders a vertical segment of color X' do
        large_bitmap.vertical_segment(4, 2, 4, 'X')
        expect(large_bitmap.render).to eq("OOOOOO\nOOOXOO\nOOOXOO\nOOOXOO\nOOOOOO")
      end
    end

    context 'for a vertical segmented inverted (bottom to top)' do
      it 'renders a vertical segment of color X' do
        large_bitmap.vertical_segment(3, 3, 1, 'X')
        expect(large_bitmap.render).to eq("OOXOOO\nOOXOOO\nOOXOOO\nOOOOOO\nOOOOOO")
      end
    end
  end

  describe '#render' do
    context 'for a bitmap with no size given' do
      it 'renders a white 1x1 bitmap' do
        expect(empty_bitmap.render).to eq('O')
      end
    end

    context 'for a white 3x2 size bitmap' do
      it 'renders a white 3x2 bitmap' do
        expect(bitmap.render).to eq("OOO\nOOO")
      end
    end
  end
end
