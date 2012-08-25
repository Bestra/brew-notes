require 'csv'
namespace :db do
  desc "Read the fermentables .csv file in /app/assets/"
  task populate_fermentables: :environment do
    CSV.foreach('app/assets/fermentablesList.csv', headers: true, col_sep: "\t") do |row|
      Fermentable.create!(row.to_hash)
      puts row.to_hash
    end
  end
  desc "Read the hops .csv file in /app/assets/"
  task populate_hops: :environment do
    CSV.foreach('app/assets/hopList.csv', headers: true, col_sep: "\t") do |row|
      h = row.to_hash.slice("name", "description")
      puts h
      Hop.create!(h)
    end
  end
end

