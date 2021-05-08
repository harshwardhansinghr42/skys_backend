require 'rails_helper'

RSpec.describe User, type: :model do
	it 'is not valid without a phone or email' do
		user = build(:user)
		expect(user).not_to be_valid
		expect(user.errors.full_messages).to include 'Email or Phone must be present'
	end

	it 'must have unique phone number' do
		user1 = create(:user, :phone)
		user2 = build(:user, phone: user1.phone)
		expect(user2).not_to be_valid
		expect(user2.errors.full_messages).to include 'Phone has already been taken'
	end

	it 'must have unique email' do
		user1 = create(:user, :email)
		user2 = build(:user, email: user1.email)
		expect(user2).not_to be_valid
		expect(user2.errors.full_messages).to include 'Email has already been taken'
	end

	it 'must have valid email format' do
		user = build(:user, email: 'abcd1212')
		expect(user).not_to be_valid
		expect(user.errors.full_messages).to include 'Email is invalid'
	end

	it 'must generate otp for user' do
  	user = create(:user, :phone)
  	expect(user.otp).to be_present
  end

	it 'must send otp verification email' do
		expect { create(:user, :email) }.to change { ActionMailer::Base.deliveries.count }.by(1)
	end
end
