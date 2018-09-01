module ContributorsDump
  class CLI
    attr_accessor :formatter, :provider, :writer, :repository, :target

    def self.from_arguments
      instance = new

      arguments = ARGV.dup
      positional_arguments = []
      while (argument = arguments.shift)
        case argument
        when '-f' then instance.formatter = initialize_formatter(arguments.shift)
        when '-p' then instance.provider = initialize_provider(arguments.shift)
        else positional_arguments << argument
        end
      end
      instance.repository, instance.target = positional_arguments 

      if instance.target
        instance.formatter ||= Formatter::CSV.new
        instance.writer = Writer::File.new
      else
        instance.formatter ||= Formatter::Table.new
        instance.writer = Writer::Stdout.new
      end

      instance
    end

    def call
      Exporter.new(
        formatter: formatter,
        provider: provider,
        writer: writer
      ).call(repository, target)
    end

    private

    def self.initialize_formatter(name)
      @formatter = Formatter.const_get(name).new
    end
    
    def self.initialize_provider(name)
      @provider = Provider.const_get(name).new
    end
  end
end

