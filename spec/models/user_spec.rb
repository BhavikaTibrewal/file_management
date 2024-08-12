require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(User.new(user_name: 'testuser', full_name: 'test', email: 'test@test.com', password: 'TestTest1')).to be_valid
  end

  it 'is not valid without a username' do
    user = User.new(user_name: nil, full_name: 'test', email: 'test@test.com', password: 'TestTest')
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("Password must contain atleast one uppercase, lowercase and number")
  end

  it 'is not valid without a name' do
    user = User.new(user_name: 'testuser', full_name: nil, email: 'test@test.com', password: 'TestTest')
    expect(user).to be_invalid
    expect(user.errors[:full_name]).to include("can't be blank")
  end

  it 'is not valid without a email' do
    user = User.new(user_name: 'testuser', full_name: 'test', email: nil, password: 'TestTest')
    expect(user).to be_invalid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is not valid without a password' do
    user = User.new(user_name: nil, full_name: 'test', email: 'test@test.com', password: nil)
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("Password must contain atleast one uppercase, lowercase and number")
  end

  it 'is not valid without a password in correct format' do
    expect(User.new(user_name: 'testuser', full_name: 'test', email: 'test@test.com', password: 'test')).to be_invalid
  end
end
