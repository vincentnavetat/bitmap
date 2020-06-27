# frozen_string_literal: true

require 'bitmap'

RSpec.describe Bitmap do
  let(:empty_bitmap) { Bitmap.new }
  let(:bitmap) { Bitmap.new(3, 2) }

  describe '#color_pixel' do
    context 'for a bitmap with white pixels' do
      it 'colors the selected pixel' do
        bitmap.color_pixel(2, 2, 'W')
        expect(bitmap.render).to eq("OOO\nOWO")
      end
    end
  end

  describe '#clear' do
    context 'for a white bitmap with one pixel of color W' do
      it 'renders a white 3x2 bitmap' do
        bitmap.color_pixel(2, 2, 'W')
        bitmap.clear()
        expect(bitmap.render).to eq("OOO\nOOO")
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
