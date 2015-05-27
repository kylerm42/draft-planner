describe Collection, type: :model do
  it 'should create sheets for each position with new record' do
    collection = create(:collection)
    expect(collection.sheets.count).to eq 6

    positions = collection.sheets.map(&:position)
    expect(positions).to eq ['qb', 'rb', 'wr', 'te', 'k', 'def']
  end
end
