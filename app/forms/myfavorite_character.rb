class MyfavoriteCharacter
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :genre_id, :integer
  attr_accessor :character_ids
  attribute :user_id, :integer
  attribute :mygenre_id, :integer
  attribute :character_id, :integer

  validates :user_id, presence: true

  def save
    return if invalid?
    ActiveRecord::Base.transaction do
      mygenre = Mygenre.create!(user_id: user_id, genre_id: genre_id)
      character_ids.each do |character_id|
        MygenreFavoriteCharacter.create!(mygenre_id: mygenre.id, character_id: character_id)
      end
    end
    true
  end
end
