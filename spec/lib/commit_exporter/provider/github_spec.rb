module CommitExporter
  module Provider
    describe Github do
      subject { described_class.new(access_token: 'abc') }
      let(:github) { subject }

      describe '#contributors' do
        before do
          stub_request(:get, 'https://api.github.com/repos/octocat/Hello-World/stats/contributors')
            .with(query: { access_token: 'abc' })
            .to_return(body: open('./spec/fixtures/contributors.json').read)
        end

        it 'returns contributors of given repository' do
          expect(github.contributors('octocat/Hello-World')).to eq [
            Contributor.new(
              login: 'octocat',
              avatar_url: 'https://github.com/images/error/octocat_happy.gif',
              commits_count: 135
            )
          ]
        end
      end
    end
  end
end
