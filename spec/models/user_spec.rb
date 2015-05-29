describe User, type: :model do
  it 'should not allow multiple users with the same email address' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, email: user1.email)

    expect(user2).not_to be_valid
  end

  it 'should require password length of 6' do
    user = FactoryGirl.build(:user, password: 'test')
    expect(user).not_to be_valid
  end
end
