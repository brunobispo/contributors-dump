require 'uri'
require 'net/http'
require 'json'

module ContributorsDump
  module Provider
    class Github
      API_HOST = 'https://api.github.com'.freeze

      def call(repository)
        fetch_users fetch_contributors(repository)
      end

      private

      def fetch_contributors(repository)
        parse_contributors get("repos/#{repository}/stats/contributors")
      end

      def parse_contributors(data)
        data.map do |contributor_data|
          Contributor.new(
            login: contributor_data['author']['login'],
            avatar_url: contributor_data['author']['avatar_url'],
            commits_count: contributor_data['total']
          )
        end
      end

      def fetch_users(contributors)
        contributors.each do |contributor|
          user_data = get("users/#{contributor.login}")
          contributor.name = user_data['name']
          contributor.email = user_data['email']
        end
      end

      def get(path)
        uri = URI("#{API_HOST}/#{path}")
        request = Net::HTTP::Get.new(uri)
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
        JSON.parse(response.body)
      end
    end
  end
end
