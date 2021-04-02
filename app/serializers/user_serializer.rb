# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :phone, :email, :name
end
