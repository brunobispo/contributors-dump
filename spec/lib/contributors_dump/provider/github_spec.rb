module ContributorsDump
  module Provider
    describe Github do
      subject { described_class.new(access_token: access_token) }
      let(:github) { subject }
      let(:access_token) { 'abc' }

      describe '#access_token' do
        let(:access_token) { nil }

        it 'assumes ENV[GITHUB_ACCESS_TOKEN] by default' do
          allow(ENV).to receive(:[]).with('GITHUB_ACCESS_TOKEN').and_return('foo')

          expect(github.access_token).to eq 'foo'
        end
      end

      describe '#call' do
        before do
          stub_request(:get, 'https://api.github.com/repos/octocat/Hello-World/stats/contributors')
            .with(query: { access_token: 'abc' })
            .to_return(body: open('./spec/fixtures/contributors.json').read)

          stub_request(:get, 'https://api.github.com/users/octocat')
            .with(query: { access_token: 'abc' })
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
