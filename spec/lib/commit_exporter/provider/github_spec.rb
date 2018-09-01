module CommitExporter
  module Provider
    describe Github do
      subject { described_class.new }
      let(:github) { subject }

      describe '#call' do
        before do
          stub_request(:get, 'https://api.github.com/repos/octocat/Hello-World/stats/contributors')
            .to_return(body: open('./spec/fixtures/contributors.json').read)

          stub_request(:get, 'https://api.github.com/users/octocat')
            .to_return(body: open('./spec/fixtures/user.json').read)
        end

        it 'returns contributors of given repository' do
          expect(github.call('octocat/Hello-World')).to eq [
            Contributor.new(
              login: 'octocat',
              name: 'monalisa octocat',
              email: 'octocat@github.com',
              avatar_url: 'https://github.com/images/error/octocat_happy.gif',
              commits_count: 135
            )
          ]
        end
      end
    end
  end
end
