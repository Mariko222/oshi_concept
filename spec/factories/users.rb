FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ニックネーム#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { "general" }

    after(:create) do |user|
      create(:mygenre, user: user)
    end
  end
end
