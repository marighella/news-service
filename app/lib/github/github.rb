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
    raw_data = search(filter)
    raw_data = filter_by_title(raw_data, filter[:title])
    raw_data.map { |item| to_post(item) }
  end

  def search filter
    raw_data = []
    begin
      if(filter[:month])
        raw_data = @client.contents @full_name, path:path(filter)
      else
        raw_data = @client.search_code "repo:#{@organization}/#{@repository} path:#{path(filter)} extension:md"
        raw_data = raw_data[:items]
      end
    rescue Octokit::NotFound
      raw_data = []
    end
    raw_data
  end

  def filter_by_title raw_data, title = nil
    return raw_data if title.nil?

    raw_data.select do |item|
      item[:name] =~ Regexp.new(title)
    end
  end

  def post id
    raw_post = @client.contents @full_name, path:id
    post = to_post(raw_post)
    post[:metadata], post[:body] = decode(raw_post[:content])
    post
  end

  private
  def path filter
    path = "_posts/#{filter.year}"
    path += ("/%02d" % filter.month.to_i) if filter.month
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
    parts = content.force_encoding('UTF-8').split('---')
    parts = parts.select {|part| not part.empty?}
    metadata = YAML.load(parts.shift)
    body    = parts.join('---')
    return metadata, body
  end
end
