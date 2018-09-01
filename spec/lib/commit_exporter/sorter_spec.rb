module CommitExporter
  describe Sorter do
    let(:sorter) { subject }

    let(:contributor_1) { instance_double(Contributor, commits_count: 3) }
    let(:contributor_2) { instance_double(Contributor, commits_count: 5) }
    let(:contributor_3) { instance_double(Contributor, commits_count: 10) }
    let(:contributors) { [contributor_1, contributor_2, contributor_3] }

    describe '#fetch' do
      it 'returns an ordered list' do
        expect(sorter.call(contributors))
          .to eq [contributor_3, contributor_2, contributor_1]
      end
    end
  end
end
