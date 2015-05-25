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

    it 'should return all posts for the given organization' do
      get "/organization/#{@organization}/#{@repository}/posts"
      response = JSON.parse(last_response.body)

      assert response.kind_of?(Array)
      response.each do |post|
        assert is_valid_post?(post), "#{post} is not a valid post"
      end
    end
  end

  def is_valid_post? post
    required_fields = ['sha', 'path', 'name']

    (required_fields - post.keys).size == 0
  end
end
