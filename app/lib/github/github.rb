require 'octokit'
class Github

  def initialize organization, repository
    @organization = organization
    @repository = repository
  end

  def posts
    raw_data = Octokit.search_code "repo:#{@organization}/#{@repository} extension:md"
    raw_data[:items].map{ |item| to_post(item) }
  end

  private
  def to_post github_post
    {
      name: github_post[:name],
      sha: github_post[:sha],
      path: github_post[:path]
    }
  end
end
