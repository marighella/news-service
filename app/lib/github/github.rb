require 'octokit'
class Github

  def initialize organization, repository
    @organization = organization
    @repository = repository
    @client = Octokit::Client.new client_id:ENV['CLIENT_ID'], client_secret:ENV['CLIENT_SECRET']
  end

  def posts filter
    raw_data = @client.search_code "repo:#{@organization}/#{@repository} path:#{path(filter)} extension:md"
    raw_data[:items].map{ |item| to_post(item) }
  end

  private
  def path filter
    path = "_posts/#{filter.year}"
    path += ("/%02d" % filter.month) if filter.month
    path
  end

  def to_post github_post
    {
      name: github_post[:name],
      sha: github_post[:sha],
      path: github_post[:path],
      metadata: metadata(github_post)
    }
  end

  def metadata github_post
    raw_post = @client.contents github_post[:repository].full_name, path:github_post[:path]
    content = Base64.decode64(raw_post[:content])
    YAML.load(content)
  end
end
