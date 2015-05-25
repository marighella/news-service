require 'octokit'
class Github

  def initialize organization, repository
    @organization = organization
    @repository = repository
  end

  def posts
    raw_data = Octokit.search_code "repo:#{@organization}/#{@repository} path:_posts extension:md"
    raw_data[:items].map{ |item| to_post(item) }
  end

  private
  def to_post github_post
    {
      name: github_post[:name],
      sha: github_post[:sha],
      path: github_post[:path],
      metadata: metadata(github_post)
    }
  end

  def metadata github_post
    raw_post = Octokit.contents github_post[:repository].full_name, path:github_post[:path]
    content = Base64.decode64(raw_post[:content])
    YAML.load(content)
  end
end
