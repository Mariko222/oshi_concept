FactoryBot.define do
  factory :mygenre_favorite_character do
    association :mygenre
    id { 1 }
    mygenre_id { mygenre.id }
    character_id { 1 }
  end
end
