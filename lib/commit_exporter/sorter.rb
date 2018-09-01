module CommitExporter
  class Sorter
    def call(contributors)
      contributors.sort { |contributor| contributor.commits_count }
    end
  end
end
