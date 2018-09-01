module ContributorsDump
  describe Contributor do
    let(:github) { subject }

    describe '#==' do
      context 'when all attributes match' do
        subject { described_class.new(login: 'abc', avatar_url: 'http://google.com', commits_count: 1) }
        let(:other) { described_class.new(login: 'abc', avatar_url: 'http://google.com', commits_count: 1) }

        it { is_expected.to eq other }
      end

      context 'when one attribute does not match' do
        subject { described_class.new(login: 'abc', avatar_url: 'http://google.com', commits_count: 1) }
        let(:other) { described_class.new(login: '123', avatar_url: 'http://google.com', commits_count: 1) }

        it { is_expected.not_to eq other }
      end
    end
  end
end

