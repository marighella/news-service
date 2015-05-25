require_relative '../../test_helper.rb'

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
  end

  def is_valid_post? post
    required_fields = ['sha', 'path', 'name']

    (required_fields - post.keys).size == 0
  end
end
