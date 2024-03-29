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
#  index_posts_on_mygenre_id          (mygenre_id)
#  index_posts_on_url_and_mygenre_id  (url,mygenre_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (mygenre_id => mygenres.id)
#
class Post < ApplicationRecord
  belongs_to :mygenre
  has_one :user, through: :mygenre
  self.inheritance_column = :_type_disabled

  enum category: { fashion: 0, item: 1, place: 2}
  enum type: { twitter: 0, webpage: 1}

  validates :mygenre_id, presence: true
  validates :type, presence: true
  validates :category, presence: true
  validates :url, uniqueness: { scope: :mygenre_id }
  validates :url, presence: true, length: { maximum: 800}, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :url, format: { with: /(https|http):\/\/(twitter.com)\/([A-Za-z0-9_]*)\/(status|statues)\/(\d+)/ }, if: :type_twitter?
  validates :url, format: { without: /(https|http):\/\/(twitter.com)\/([A-Za-z0-9_]*)\/(status|statues)\/(\d+)/ }, if: :type_webpage?

  def type_twitter?
    type == "twitter"
  end

  def type_webpage?
    type == "webpage"
  end
end
