class PostSerializer < ActiveModel::Serializer
  attributes :id, :mygenre_id, :category, :type, :url, :created_at, :title, :image, :tweet_url

  def tweet_url
    if object.type == 'twitter'
    u = object.url.split('/')
    s = u[u.length-1]
    tweet_url = s[0,s.index('?')]
    end
  end
end
