# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :first_name, :last_name, :birthdate, :address, :created_at
    end
  end
end
