class Post
  attr_reader :sha, :path, :name, :metadata

  def to_json(*a)
    { sha:@sha,
      path:@path,
      name:@name,
      metadata:@metadata }.to_json
  end
end

class Organization
  def initialize
  end

  def self.get
    Organization.new
  end

  def posts
    [1..10].map{ |sha| Post.new }
  end
end
