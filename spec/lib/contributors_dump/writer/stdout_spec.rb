module ContributorsDump
  module Writer
    describe Stdout do
      let(:writer) { subject }
      let(:data) { 'foo bar baz' }

      describe '#call' do
        it 'echoes the given data to stdout' do
          expect { writer.call(data, nil) }.
            to output("#{data}\n").to_stdout
        end
      end
    end
  end
end

