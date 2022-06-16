require 'csv'

csv = CSV.read('db/fixtures/csv/characters.csv', headers: true)
csv.each do |character|
  Character.seed do |s|
    s.id = character[0]
    s.name = character[1]
    s.genre_id = character[2]
  end
end
