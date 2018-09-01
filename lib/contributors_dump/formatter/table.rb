require 'byebug'

module ContributorsDump
  module Formatter
    class Table
      COLUMNS = {
        name: 'Name',
        email: 'Email',
        login: 'Login',
        avatar_url: 'Avatar',
        commits_count: 'Commits'
      }

      def call(contributors)
        sizes = calculate_sizes(contributors)
        table = header(sizes)

        contributors.each do |contributor|
          table << line(
            {
              name: contributor.name,
              email: contributor.email,
              login: contributor.login,
              avatar_url: contributor.avatar_url,
              commits_count: contributor.commits_count
            },
            sizes
          )
        end

        table
      end

      private

      def calculate_sizes(contributors)
        contributors.each_with_object(
          COLUMNS.map { |(name, label)| [name, label.size] }.to_h
        ) do |contributor, hash|
          hash.each do |name, size|
            hash[name] = [size, contributor.send(name)&.size].compact.max
          end
        end
      end

      def header(sizes)
        divider(sizes) + line(COLUMNS, sizes)
      end

      def divider(sizes)
        "+-#{sizes.map { |_, size| '-' * size }.join('-+-') }-+\n"
      end

      def line(values, sizes)
        "| #{COLUMNS.keys.map { |name| values[name].to_s.ljust(sizes[name]) }.join(' | ')} |\n" + divider(sizes)
      end
    end
  end
end

