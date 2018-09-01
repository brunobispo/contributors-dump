module CommitExporter
  module Writer
    class Stdout
      def call(data, _target)
        puts data
      end
    end
  end
end
