module CommitExporter
  class Fetcher
    attr_accessor :provider

    def initialize(provider:)
      @provider = provider
    end

    def fetch(repository)
      provider.contributors(repository)
        .sort { |contributor| contributor.commits_count }
    end
  end
end
