require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = User.create!(
      first_name: "s1",
      last_name: "p1",
      email: "123@abc.com",
      password: "123",
      password_confirmation: "123"
    )
    @user2 = User.new(
      first_name: "sindhu",
      last_name: "priya",
      email: "1n23@ABC.com",
      password: "123",
      password_confirmation: "123"
    )
  end

  describe "Validation" do
    it "should return error if password is nil" do
      @user2.password = nil
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Password can't be blank")
    end

    it "should return error if email already exist" do
        @user2.email = @user1.email
        @user2.valid?
        expect(@user2.errors.full_messages).to_not eql([])
    end

    it "should return error if any one first_name, last_name, email is nil" do
      @user2.first_name = nil
      @user2.last_name = nil
      @user2.email = nil
      @user2.valid?
      expect(@user2.errors.full_messages).to include("First name can't be blank")
      expect(@user2.errors.full_messages).to include("Last name can't be blank")
      expect(@user2.errors.full_messages).to include("Email can't be blank")
    end

    it "should return error if password shorter than minimum length" do
       @user2.password = 'ab'

       expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'works on a valid user' do
      user = User.authenticate_with_credentials('123@abc.com', '123')
      expect(user).to eql(@user1)
    end

    it 'fails on an invalid password' do
      user = User.authenticate_with_credentials('123@abc.com', 'WRONG PASSWORD')
      expect(user).to eql(nil)
    end

    it 'fails on an invalid email' do
      user = User.authenticate_with_credentials('1234@abc.com','123')
      expect(user).to eql(nil)
    end

    it 'should pass if email contains spaces before and after' do
      user = User.authenticate_with_credentials(' 123@abc.com ','123')
      expect(user).to eql(@user1)
    end

    it 'should pass if email contains capital or small letters' do
      user = User.authenticate_with_credentials('123@aBc.com','123')
      expect(user).to eql(@user1)
    end
  end
end
