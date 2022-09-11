FactoryBot.define do
  factory :mygenre do
    association :user

    after(:create) do |mygenre|
      create_list(:mygenre_favorite_character, 3, mygenre: mygenre)
      genre_id { rand(1..5) }
    end
  end
end
