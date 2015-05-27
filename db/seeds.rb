require 'csv'

players = CSV.open('lib/nfl_stats_2014.csv', headers: true, header_converters: :symbol, converters: :all)
kickers = CSV.open('lib/nfl_stats_kickers_2014.csv', headers: true, header_converters: :symbol, converters: :all)
defenses = CSV.open('lib/nfl_stats_defenses_2014.csv', headers: true, header_converters: :symbol, converters: :all)

Player.transaction do
  players.to_a.each do |row|
    row[:birthdate] = Date.strptime(row[:birthdate], '%m/%d/%y')
    Player.create(row.to_hash)
  end

  kickers.to_a.each do |row|
    row[:birthdate] = Date.strptime(row[:birthdate], '%m/%d/%y')
    Player.create(row.to_hash)
  end

  defenses.to_a.each do |row|
    Player.create(row.to_hash)
  end
end
