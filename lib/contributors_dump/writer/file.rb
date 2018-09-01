module ContributorsDump
  module Writer
    class File
      def call(data, filename)
        open(filename, 'w') do |file|
          file.write data
        end
      end
    end
  end
end
