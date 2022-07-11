# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  category   :integer          default("fashion"), not null
#  image      :string
#  text       :text
#  title      :string
#  type       :integer          default("twitter"), not null
#  url        :string
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
class Post < ApplicationRecord
  belongs_to :mygenre
  self.inheritance_column = :_type_disabled

  enum category: { fashion: 0, item: 1, place: 2}
  enum type: { twitter: 0, webpage: 1}

  validates :url, length: { maximum: 200}
end
