require 'csv'

csv = CSV.read('db/fixtures/csv/genres.csv', headers: true)
csv.each do |genre|
  Genre.seed do |s|
    s.id = genre[0]
    s.name = genre[1]
  end
end
