require_relative 'test_helper.rb'

describe News::API do
  def app
    News::API
  end

  describe 'when I peform a http GET on /<organization>/posts' do
    it 'should return all posts for the given organization' do
      organization = 'marighella'
      get "/organization/#{organization}/posts"
      response = JSON.parse(last_response.body)

      response.each do |post|
        assert is_valid_post?(post), "#{post} is not a valid post"
      end
    end
  end

  def is_valid_post? post
    required_fields = ['sha', 'path', 'name', 'metadata']

    (required_fields - post.keys).size == 0
  end

end

