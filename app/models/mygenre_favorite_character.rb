# == Schema Information
#
# Table name: mygenre_favorite_characters
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint           not null
#  mygenre_id   :bigint           not null
#
# Indexes
#
#  index_mygenre_favorite_characters_on_character_id  (character_id)
#  index_mygenre_favorite_characters_on_mygenre_id    (mygenre_id)
#  mygenre_favorite_characters_index                  (mygenre_id,character_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (mygenre_id => mygenres.id)
#
class MygenreFavoriteCharacter < ApplicationRecord
  belongs_to :mygenre
  belongs_to :character

  validates :mygenre_id, uniqueness: { scope: :character_id }
end
