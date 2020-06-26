# frozen_string_literal: true

require 'bitmap'

RSpec.describe Bitmap do
  let(:bitmap) { Bitmap.new }

  context 'when no size given' do
    it 'default size is 1x1' do
      expect(bitmap.render).to eq('O')
    end
  end
end
