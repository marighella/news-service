require_relative 'github/github.rb'

class Organization
  def initialize organization_id = nil, repository_id = nil
    @repository = get_repository(organization_id, repository_id)
  end

  def self.get organization_id = nil, repository_id = nil
    Organization.new(organization_id, repository_id)
  end

  def post id = nil
    {
      name:1,
      sha: 2,
      path: 3
    }
  end

  def posts
    @repository.posts
  end

  def get_repository organization_id, repository_id
    Github.new organization_id, repository_id
  end
end
