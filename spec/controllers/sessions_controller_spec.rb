require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
	describe 'sessions controller' do
		it 'should render with errors' do
			delete :destroy, params: { id: 1 }
			expect(response.status).to eq(422)
			expect(JSON.parse(response.body)['errors']).to eq('user not found')
		end

		it 'should update the session expired at for user' do
			user = create(:user, :email)
			delete :destroy, params: { id: user.id }
			expect(response.status).to eq(200)
			expect(user.reload.session_expired_at).not_to be_nil
		end
	end
end