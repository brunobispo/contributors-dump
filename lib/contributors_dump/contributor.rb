module ContributorsDump
  class Contributor
    attr_accessor :login, :name, :email, :avatar_url, :commits_count

    def initialize(login: nil, name: nil, email: nil, avatar_url: nil, commits_count: nil)
      @login = login
      @name = name
      @email = email
      @avatar_url = avatar_url
      @commits_count = commits_count
    end

    def ==(other)
      attributes == other.attributes
    end

    protected

    def attributes
      instance_variables.map { |variable| instance_variable_get variable }
    end
  end
end
