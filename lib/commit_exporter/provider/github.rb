require 'uri'
require 'net/http'
require 'json'

module CommitExporter
  module Provider
    class Github
      attr_accessor :access_token

      def initialize(access_token:)
        @access_token = access_token
      end

      def contributors(repository)
        parse fetch(repository)
      end

      private

      def fetch(repository)
        uri = URI("https://api.github.com/repos/#{repository}/stats/contributors")
        uri.query = URI.encode_www_form(access_token: access_token)
        request = Net::HTTP::Get.new(uri)
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
        response.body
      end

      def parse(data)
        data = JSON.parse(data)
        data.map do |contributor_data|
          Contributor.new(
            login: contributor_data['author']['login'],
            avatar_url: contributor_data['author']['avatar_url'],
            commits_count: contributor_data['total']
          )
        end
      end
    end
  end
end
