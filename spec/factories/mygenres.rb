FactoryBot.define do
  factory :mygenre do
    association :user
    id { SecureRandom }
    user_id { user.id }
    genre_id { 1 }
  end
end
