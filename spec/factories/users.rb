FactoryBot.define do
	factory :user do
		trait :phone do
			phone { Faker::PhoneNumber.phone_number }
		end

		trait :email do
			email { Faker::Internet.email }
		end

		factory :user_with_email_and_phone, traits: [:phone, :email]
	end
end