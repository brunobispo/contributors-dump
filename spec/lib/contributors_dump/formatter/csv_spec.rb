module ContributorsDump
  module Formatter
    describe CSV do
      let(:csv) { subject }
      let(:contributor_1) do
        instance_double Contributor,
                        login: 'foo',
                        name: 'Foo',
                        email: 'foo@bar.com',
                        avatar_url: 'http://goog.com',
                        commits_count: 3
      end

      let(:contributor_2) do
        instance_double Contributor,
                        login: 'bar',
                        name: 'Bar',
                        email: 'bar@foo.com',
                        avatar_url: 'http://goog.net',
                        commits_count: 5
      end

      describe '#call' do
        it 'returns a csv formatted string' do
          output = csv.call([contributor_1, contributor_2])
          expect(output).to eq <<-csv.gsub("\s", '')
            Foo;foo@bar.com;foo;http://goog.com;3
            Bar;bar@foo.com;bar;http://goog.net;5
          csv
        end
      end
    end
  end
end

