FactoryBot.define do
  factory :mygenre_favorite_character do
    association :mygenre
    character_id{ 1 }
  end
end
