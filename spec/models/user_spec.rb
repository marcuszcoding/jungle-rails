require 'rails_helper'


RSpec.describe UserSpec, type: :model do
  it 'should have a minimun password length' do
    @user = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: "123", password_confirmation: "123")
    @user.save
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end
  it 'should show error message if name is not set' do
    @user = User.new(name: nil, email: 'mar.zimmer@hotmail.com', password: "123456", password_confirmation: "123456")
    @user.save
    expect(@user.errors.full_messages).to include("Name can't be blank")
  end
  it 'should not save if password and password_confirmation do not match' do
    @user = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: "123456", password_confirmation: "11111")
    @user.save 
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end
  it 'should show error message if password is not set' do
    @user = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: nil, password_confirmation: nil)
    @user.save
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end
  it 'should show error message if email is not set' do
    @user = User.new(name: 'Marcus', email: nil, password: "123456", password_confirmation: "123456")
    @user.save
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end
  it 'should provide an error message if email is not unique' do
    @user_1 = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: "123456", password_confirmation: "123456")
    @user_1.save
    @user_2 = User.new(name: 'Domara', email: 'mar.zimmer@hotmail.com', password: "654321", password_confirmation: "654321")
    @user_2.save
    expect(@user_2.errors.full_messages).to include("Email has already been taken")
  end
end

describe '.authenticate_with_credentials' do
  it 'should only log-in user with valid credentials' do
    @user = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: "123456", password_confirmation: "123456")
    @user.save
    @user_logged_in = User.authenticate_with_credentials('mar.zimmer@hotmail.com', "123456")
    expect(@user_logged_in).to_not eq(nil)
  end
  it 'should authenticate user if email contains trailing spaces' do
    @user = User.new(name: 'Marcus', email: 'mar.zimmer@hotmail.com', password: "123456", password_confirmation: "123456")
    @user.save
    @user_logged_in = User.authenticate_with_credentials(' mar.zimmer@hotmail.com ', "123456")
    expect(@user_logged_in).to_not eq(nil)
  end
  it 'should authenticate user if email in the wrong case' do
    @user = User.new(name: 'Marcus', email: 'MAR.ZIMMER@HOTMAIL.COM', password: "123456", password_confirmation: "123456")
    @user.save
    @user_logged_in = User.authenticate_with_credentials('mar.zimmer@hotmail.com', "123456")
    expect(@user_logged_in).to_not eq(nil)
  end
end