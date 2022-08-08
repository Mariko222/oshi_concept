# == Schema Information
#
# Table name: characters
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint           not null
#
# Indexes
#
#  index_characters_on_genre_id           (genre_id)
#  index_characters_on_genre_id_and_name  (genre_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#
class Character < ApplicationRecord
  belongs_to :genre
  has_many :mygenre_favorite_characters
  has_many :mygenres, through: :mygenre_favorite_characters

  validates :name, presence: true, uniqueness: { scope: :genre }
end
