require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
	describe 'Create Registrations' do
		it 'creates a user by email' do
			email = Faker::Internet.email
			post :create, params: { email_or_phone: email }
			expect(response.status).to eq(200)
			expect(JSON.parse(response.body)['email']).to eq email
		end

		it 'creates a user by phone' do
			phone = Faker::PhoneNumber.phone_number
			post :create, params: { email_or_phone: phone }
			expect(response.status).to eq(200)
			expect(JSON.parse(response.body)['phone']).to eq phone
		end

		it 'returns the existing user with email' do
			user = create(:user, :email)
			post :create, params: { email_or_phone: user.email }
			expect(JSON.parse(response.body)['email']).to eq(user.email)
		end

		it 'returns the existing user with phone' do
			user = create(:user, :phone)
			post :create, params: { email_or_phone: user.phone }
			expect(JSON.parse(response.body)['phone']).to eq(user.phone)
		end
	end
end