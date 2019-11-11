# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

data = JSON.parse(File.read(File.join Rails.root,'db', 'seed_data', 'rates.json'))

data['rates'].each do |entry|
  RatesHistory.find_or_create_by!(entry)

  # Normalize USD to CHF.
  if entry['to_currency'] == 'USD'
    date = entry['date']
    chf_to_eur_entry_for_date = data['rates'].find { |d| (d['date'] == date) && (d['to_currency'] != 'USD') }
    rate = (entry['rate'] - chf_to_eur_entry_for_date['rate']).abs

    RatesHistory.find_or_create_by!(date: date, from_currency: 'USD', to_currency: 'CHF', rate: rate)
  end
end
