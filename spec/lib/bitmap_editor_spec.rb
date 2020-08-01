require 'bitmap_editor'

RSpec.describe BitmapEditor do
  subject(:run) { described_class.new.run(path) }

  context '.run' do
    context 'with wrong file path' do
      let(:path) { 'wrong/path/file.txt' }

      it 'returns an error message asking for a correct path' do
        expect { run }.to output("Please provide correct file\n").to_stdout
      end
    end

    context 'with empty file' do
      let(:path) { 'spec/fixtures/empty.txt' }

      it 'returns an error message indicating no command found' do
        expect { run }.to output("No command found\n").to_stdout
      end
    end

    context 'with file showing no initialised bitmaps' do
      let(:path) { 'spec/fixtures/no_bitmap.txt' }

      it 'returns an error message indicating no command found' do
        expect { run }.to output("There is no image\n").to_stdout
      end
    end

    context 'with file showing initial white bitmap' do
      let(:path) { 'spec/fixtures/init.txt' }

      it 'shows a white bitmap of 3 x 2' do
        expect { run }.to output("OOO\nOOO\n").to_stdout
      end

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

      it 'shows a white bitmap with one pixel of color As' do
        expect { run }.to output("OOO\nAOO\n").to_stdout
      end
    end

    context 'using C command on a bitmap with a pixel of different color' do
      let(:path) { 'spec/fixtures/clear.txt' }

      it 'shows a white bitmap of 3 x 2' do
        expect { run }.to output("OOO\nOOO\n").to_stdout
      end
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

      it 'shows bitmap as expected' do
        expect { run }.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout
      end
    end

    context 'file with a fill instruction' do
      let(:path) { 'spec/fixtures/fill.txt' }

      it 'shows bitmap as expected' do
        expect { run }.to output("AAAAAAA\nAAAAAAA\nAAAAAAA\nAAAAAAA\n").to_stdout
      end
    end
  end
end
