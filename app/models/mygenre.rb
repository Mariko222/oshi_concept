# == Schema Information
#
# Table name: mygenres
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_mygenres_on_genre_id              (genre_id)
#  index_mygenres_on_user_id               (user_id)
#  index_mygenres_on_user_id_and_genre_id  (user_id,genre_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#  fk_rails_...  (user_id => users.id)
#
class Mygenre < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :mygenre_favorite_characters, dependent: :destroy
  has_many :characters, through: :mygenre_favorite_characters
  has_many :posts, dependent: :destroy

  validates :user_id, uniqueness: { scope: :genre_id }
  validates :mygenre_favorite_characters, length: { minimum: 1 }, on: :update
  validates :mygenre_favorite_characters, length: { maximum: 4 }
end
