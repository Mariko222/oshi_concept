# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  category   :integer          default("fashion"), not null
#  image      :string
#  title      :string
#  type       :integer          default("twitter"), not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mygenre_id :bigint           not null
#
# Indexes
#
#  index_posts_on_mygenre_id  (mygenre_id)
#
# Foreign Keys
#
#  fk_rails_...  (mygenre_id => mygenres.id)
#
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
