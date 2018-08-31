require_relative 'provider/github'

module CommitExporter
  class Fetcher
    attr_accessor :provider

    # delegate :commits, :users, to: :provider
  end
end
