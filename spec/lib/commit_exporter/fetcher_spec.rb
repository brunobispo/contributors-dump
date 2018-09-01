module CommitExporter
  describe Fetcher do
    subject { described_class.new(provider: provider) }
    let(:fetcher) { subject }

    let(:contributor_1) { instance_double(Contributor, commits_count: 3) }
    let(:contributor_2) { instance_double(Contributor, commits_count: 5) }
    let(:contributor_3) { instance_double(Contributor, commits_count: 10) }
    let(:provider) { instance_double(Provider::Github) }

    before do
      allow(provider).to receive(:contributors).with('owner/repository')
        .and_return([contributor_1, contributor_2, contributor_3])
    end

    describe '#fetch' do
      it 'returns an ordered list' do
        expect(fetcher.fetch('owner/repository'))
          .to eq [contributor_3, contributor_2, contributor_1]
      end
    end
  end
end
