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
  def initialize id
    @id = id
  end

  def self.get id = nil
    Organization.new(id)
  end

  def posts id = nil
    unless id
      [1..10].map{ |sha| Post.new }
    else
      Post.new
    end
  end
end
