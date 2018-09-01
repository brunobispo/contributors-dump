module CommitExporter
  describe Exporter do
    subject { described_class.new }
    let(:exporter) { subject }
    let(:file_path) { "#{Dir.tmpdir}/contributors.csv" }
    let(:data) { 'foo;bar;baz' }

    describe '#write' do
      it 'saves the given data to given path' do
        exporter.write(data, file_path)

        expect(open(file_path).read).to eq data
      end
    end
  end
end
