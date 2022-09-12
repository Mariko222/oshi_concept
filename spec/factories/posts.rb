FactoryBot.define do
  factory :post do
    association :mygenre
    mygenre_id { mygenre.id }
    category { "fashion" }
    type { "twitter" }
    url { "https://twitter.com/momo95843/status/1567372677010329600?s=20&t=9ii2Qew7HohjY3sdLOSSxA" }
  end
end
