FactoryBot.define do
  factory :mygenre do
    association :user
    genre_id { 1 }
  end
end
