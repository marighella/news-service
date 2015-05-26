require_relative '../../test_helper.rb'
require 'date'

describe 'Integration with github' do
  def app
    News::API
  end

  before do
    Organization.any_instance.unstub(:get_repository)
  end

  describe 'given the organization' do
    before do
      @organization = 'marighella'
      @repository = 'blog'
    end

    it 'should return a list of posts' do
      get "/organization/#{@organization}/#{@repository}/posts"
      response = JSON.parse(last_response.body)

      assert response.kind_of?(Array)
    end

    it 'should return posts filtered by year' do
      get "/organization/#{@organization}/#{@repository}/posts?year=2015"
      posts = JSON.parse(last_response.body)

      assert_match(/2015/, posts.first['path'])
    end

    it 'should return posts filtered by month' do
      get "/organization/#{@organization}/#{@repository}/posts?month=1&year=2015"
      posts = JSON.parse(last_response.body)
      month = Date.parse(posts.first['path']).month

      JANUARY = 1

      assert_equal month, JANUARY
    end

    it 'should return a single post by path' do
      path  = '_posts/2015/01/2015-01-19-a-fe-nao-costuma.md'
      get "/organization/#{@organization}/#{@repository}/post?path=#{path}"
      posts = JSON.parse(last_response.body)

      assert posts['metadata']
    end
  end

end
