require 'csv'

players = CSV.open('lib/nfl_stats_2014.csv', headers: true, header_converters: :symbol, converters: :all)
kickers = CSV.open('lib/nfl_stats_kickers_2014.csv', headers: true, header_converters: :symbol, converters: :all)
defenses = CSV.open('lib/nfl_stats_defenses_2014.csv', headers: true, header_converters: :symbol, converters: :all)

Player.transaction do
  players.to_a.each do |row|
    row[:birthdate] = Date.strptime(row[:birthdate], '%m/%d/%y')
    row[:age] = (Time.now.to_s(:number).to_i - row[:birthdate].to_time.to_s(:number).to_i)/10e9.to_i
    Player.create(row.to_hash)
  end

  kickers.to_a.each do |row|
    row[:birthdate] = Date.strptime(row[:birthdate], '%m/%d/%y')
    row[:age] = (Time.now.to_s(:number).to_i - row[:birthdate].to_time.to_s(:number).to_i)/10e9.to_i
    Player.create(row.to_hash)
  end

  defenses.to_a.each do |row|
    Player.create(row.to_hash)
  end
end

user = User.create(email: 'test@example.com', password: 'test123', provider: 'email')
User.create(email: 'test2@example.com', password: 'test123', provider: 'email')
User.create(email: 'test3@example.com', password: 'test123', provider: 'email')

collection = user.collections.create(name: 'Test collection', default: true)

{'QB' => 40, 'RB' => 100, 'WR' => 100, 'TE' => 40, 'DEF' => 32, 'K' => 32}.each do |position, count|
  # create collection and sheets
  ranks = Player.where(position: position).order(points: :desc).limit(count).map(&:id)
  collection.sheets.create(position: position, ranks: ranks)

  # set player ranks
  Player.transaction do
    players = Player.where(position: position).order(points: :desc)
    players.each_with_index do |player, idx|
      player.update(pos_rank: idx + 1)
    end
  end
end
