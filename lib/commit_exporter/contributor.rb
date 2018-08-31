module CommitExporter
  class Contributor
    attr_accessor :login, :avatar_url, :commits_count

    def initialize(login: nil, avatar_url: nil, commits_count: nil)
      @login = login
      @avatar_url = avatar_url
      @commits_count = commits_count
    end

    def attributes
      instance_variables.map { |variable| instance_variable_get variable }
    end

    def ==(other)
      attributes == other.attributes
    end
  end
end
