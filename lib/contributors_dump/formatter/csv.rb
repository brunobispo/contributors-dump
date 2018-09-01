require 'csv'

module ContributorsDump
  module Formatter
    class CSV
      def call(contributors)
        ::CSV.generate(col_sep: ';') do |csv|
          contributors.each do |contributor|
            csv << [
              contributor.name,
              contributor.email,
              contributor.login,
              contributor.avatar_url,
              contributor.commits_count
            ]
          end
        end
      end
    end
  end
end
