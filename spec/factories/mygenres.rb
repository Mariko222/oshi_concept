FactoryBot.define do
  factory :mygenre do
    association :user
    id { SecureRandom }
    user_id { user.id }
    genre_id { 1 }

    trait :with_mygenre_favorite_characters do
      after(:create) { |mygenre| create_list(:mygenre_favorite_character, 3, mygenre: mygenre) }
    end
  end
end
