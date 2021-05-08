require 'rails_helper'

RSpec.describe Api::V1::OtpVerificationsController, type: :controller do
	describe 'Otp verifications' do
		it 'should return with error user not found' do
			post :create, params: { email_or_phone: Faker::Internet.email }
			expect(response.status).to eq(422)
			expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.user.not_found'))
		end

		it 'should return with error otp expired or invalid when no otp is provided' do
			user = create(:user, :email)
			post :create, params: { email_or_phone: user.email }
			expect(response.status).to eq(422)
			expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.user.otp_invalid'))
		end

		it 'should return with error otp expired or invalid when wrong otp is provided' do
			user = create(:user, :email)
			post :create, params: { email_or_phone: user.email, otp: user.otp.to_i + 1 }
			expect(response.status).to eq(422)
			expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.user.otp_invalid'))
		end

		it 'should return with error otp expired or invalid when wrong otp is provided is expired' do
			user = create(:user, :email)
			user.update(otp_created_at: user.otp_created_at - 10.minutes)
			post :create, params: { email_or_phone: user.email, otp: user.otp }
			expect(response.status).to eq(422)
			expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.user.otp_invalid'))
		end

		it 'should verify the otp and return authorization token in header' do
			user = create(:user, :email)
			post :create, params: { email_or_phone: user.email, otp: user.otp }
			expect(response.status).to eq(200)
			expect(JSON.parse(response.body)['id']).to eq(user.id)
			expect(response.headers["Authorization"]).not_to be_nil 
		end
	end
end