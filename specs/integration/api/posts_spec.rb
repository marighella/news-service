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

    it 'should return date, title and published to each post' do
      get "/organization/#{@organization}/#{@repository}/posts"
      response = JSON.parse(last_response.body)

      first_post = response.first

      assert first_post['metadata']
      assert first_post['metadata']['date']
      assert first_post['metadata']['title']
      assert first_post['metadata']['published']
    end

    it 'should return posts filtered by year' do
      get "/organization/#{@organization}/#{@repository}/posts?year=2015"
      posts = JSON.parse(last_response.body)

      assert_match(/2015/, posts.first['metadata']['date'])
    end

    it 'should return posts filtered by month' do
      get "/organization/#{@organization}/#{@repository}/posts?month=1&year=2015"
      posts = JSON.parse(last_response.body)
      month = Date.parse(posts.first['metadata']['date']).month

      JANUARY = 1

      assert_equal month, JANUARY
    end
  end

end
