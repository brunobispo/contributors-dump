module CommitExporter
  class Exporter
    attr_accessor :formatter, :provider, :writer, :sorter

    def initialize(formatter: nil, provider: nil, writer: nil, sorter: nil)
      @formatter = formatter || Formatter::CSV.new
      @provider = provider || Provider::Github.new
      @writer = writer || Writer::Stdout.new
      @sorter = sorter || Sorter.new
    end

    def call(repository, target)
      writer.(formatter.(sorter.(provider.(repository))), target)
    end
  end
end
