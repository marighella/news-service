require_relative '../../test_helper.rb'

describe News::API do
  def app
    News::API
  end

  before do
    post = { name:1, path:2, sha:3 }

    repo = mock()
    repo.stubs(:posts).returns([post])
    repo.stubs(:post).returns(post)

    Organization.any_instance.stubs(:get_repository).returns(repo)
  end

  describe 'given the organization' do
    before do
      @organization = 'marighella'
      @id_post = 'id'
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

    it 'should return one complete post' do
      get "/organization/#{@organization}/#{@repository}/post?path=#{@id_post}"
      response = JSON.parse(last_response.body)

      assert is_valid_post?(response), "#{response} is not a valid post"
    end
  end

  def is_valid_post? post
    required_fields = ['sha', 'path', 'name']

    (required_fields - post.keys).size == 0
  end

end

