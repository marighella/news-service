require 'octokit'

class Github

  def initialize organization, repository, access_token
    @organization = organization
    @repository = repository
    @full_name  = "#{organization}/#{repository}"
    @access_token = access_token

    unless access_token
      @client = Octokit::Client.new client_id:ENV['CLIENT_ID'], client_secret:ENV['CLIENT_SECRET']
    else
      @client = Octokit::Client.new access_token:access_token
    end
  end

  def posts filter
    raw_data = @client.search_code "repo:#{@organization}/#{@repository} path:#{path(filter)} extension:md"
    raw_data[:items].map { |item| to_post(item) }
  end

  def post id
    raw_post = Octokit.contents @full_name, path:id
    post = to_post(raw_post)
    post[:metadata] = decode(raw_post[:content])
    post
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
    }
  end

  def decode raw_content
    content = Base64.decode64(raw_content)
    YAML.load(content)
  end
end
