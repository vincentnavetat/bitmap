require 'bitmap_editor'

RSpec.describe BitmapEditor do
  subject(:run) { described_class.new.run(path) }

  shared_examples 'a valid stdout response' do
    it 'returns the correct message given the path' do
      expect { run }.to output(expected_text).to_stdout
    end
  end

  context '.run' do
    context 'with wrong file path' do
      let(:path) { 'wrong/path/file.txt' }
      let(:expected_text) { "Please provide correct file\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'with empty file' do
      let(:path) { 'spec/fixtures/empty.txt' }
      let(:expected_text) { "No command found\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'with file showing no initialised bitmaps' do
      let(:path) { 'spec/fixtures/no_bitmap.txt' }
      let(:expected_text) { "There is no image\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'with file showing initial white bitmap' do
      let(:path) { 'spec/fixtures/init.txt' }
      let(:expected_text) { "OOO\nOOO\n" }

      it_behaves_like 'a valid stdout response'

      it 'has an image of the right size' do
        editor = BitmapEditor.new
        editor.run('spec/fixtures/init.txt')
        expect(editor.bitmap.size.x).to eq(3)
        expect(editor.bitmap.size.y).to eq(2)
      end
    end

    context 'with bitmap bigger than 250 limits' do
      it 'has an image of 250x250' do
        editor = BitmapEditor.new
        editor.run('spec/fixtures/too_big.txt')
        expect(editor.bitmap.size.x).to eq(250)
        expect(editor.bitmap.size.y).to eq(250)
      end

      it 'shows a warning indicating image has been truncated' do
        expect do
          BitmapEditor.new.run('spec/fixtures/too_big.txt', '--show-warnings')
        end.to output(/The image was truncated because the size X given was larger than 250/).to_stdout
      end
    end

    context 'using commands with wrong arguments' do
      it 'shows appropriate warnings' do
        expect do
          BitmapEditor.new.run('spec/fixtures/wrong_arguments.txt', '--show-warnings')
        end.to output(/This command was ignored because of invalid parameters/).to_stdout
      end
    end

    context 'using L command' do
      let(:path) { 'spec/fixtures/paint_pixel.txt' }
      let(:expected_text) { "OOO\nAOO\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'using C command on a bitmap with a pixel of different color' do
      let(:path) { 'spec/fixtures/clear.txt' }
      let(:expected_text) { "OOO\nOOO\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'file has unknown command' do
      it 'shows a warning that file has unknown command' do
        expect do
          BitmapEditor.new.run('spec/fixtures/unknown_command.txt', '--show-warnings')
        end.to output(/Unrecognised command/).to_stdout
      end
    end

    context 'file has all possible instructions' do
      let(:path) { 'spec/fixtures/demo.txt' }
      let(:expected_text) { "OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n" }

      it_behaves_like 'a valid stdout response'
    end

    context 'file with a fill instruction' do
      let(:path) { 'spec/fixtures/fill.txt' }
      let(:expected_text) { "AAAAAAA\nAAAAAAA\nAAAAAAA\nAAAAAAA\n" }

      it_behaves_like 'a valid stdout response'
    end
  end
end
