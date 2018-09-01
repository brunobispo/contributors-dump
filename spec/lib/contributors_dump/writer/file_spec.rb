require 'tmpdir'

module ContributorsDump
  module Writer
    describe File do
      let(:writer) { subject }
      let(:file_path) { "#{Dir.tmpdir}/contributors.csv" }
      let(:data) { 'foo;bar;baz' }

      describe '#call' do
        it 'write the given data to given path' do
          writer.call(data, file_path)

          expect(open(file_path).read).to eq data
        end
      end
    end
  end
end
