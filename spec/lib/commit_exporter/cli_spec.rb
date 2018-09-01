module CommitExporter
  describe CLI do
    let(:cli) { subject } 

    describe '.from_arguments' do
      subject { described_class.from_arguments }

      before do
        stub_const('ARGV', %w[-f CSV -p Github brunobispo/dotfiles output.csv])
        stub_const('ENV', PROVIDER_ACCESS_TOKEN: 'abc')
      end

      it 'parses the format' do
        expect(cli.formatter).to be_a Formatter::CSV
      end

      it 'parses the provider' do
        expect(cli.provider).to be_a Provider::Github
      end

      it 'parses the repository' do
        expect(cli.repository).to eq 'brunobispo/dotfiles'
      end

      it 'parses the target' do
        expect(cli.target).to eq 'output.csv'
      end
    end

    describe '.call' do
      let(:exporter) { instance_double(Exporter, call: nil) }

      before do
        allow(Exporter).to receive(:new).and_return(exporter)
      end

      it 'creates an exporter instance' do
        cli.call

        expect(Exporter).to have_received(:new).with(
          formatter: cli.formatter,
          provider: cli.provider
        )
      end

      it 'calls the exporter' do
        cli.call

        expect(exporter).to have_received(:call).with(cli.repository, cli.target)
      end
    end
  end
end
