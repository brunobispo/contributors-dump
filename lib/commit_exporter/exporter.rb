require 'tmpdir'

module CommitExporter
  class Exporter
    def write(data, filename)
      open(filename, 'w') do |file|
        file.write data
      end
    end
  end
end
