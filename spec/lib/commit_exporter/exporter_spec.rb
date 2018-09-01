module CommitExporter
  describe Exporter do
    describe '#call' do
      subject do
        described_class.new formatter: formatter,
                            sorter: sorter,
                            provider: provider,
                            writer: writer
      end

      let(:exporter) { subject }
      let(:provider) { instance_double(Provider::Github) }
      let(:formatter) { instance_double(Formatter::CSV) }
      let(:sorter) { instance_double(Sorter) }
      let(:writer) { instance_double(Writer::File) }

      let(:contributors) { [instance_double(Contributor)] }
      let(:sorted_contributors) { [instance_double(Contributor)] }
      let(:output_data) { 'foo;bar;baz' }

      let(:repository) { 'owner/repository' }
      let(:target) { 'output.csv' }

      it 'fetches, sort, formats and writes result' do
        expect(provider).to receive(:call).with(repository).and_return(contributors)
        expect(sorter).to receive(:call).with(contributors).and_return(sorted_contributors)
        expect(formatter).to receive(:call).with(sorted_contributors).and_return(output_data)
        expect(writer).to receive(:call).with(output_data, target)

        exporter.call(repository, target)
      end
    end
  end
end
