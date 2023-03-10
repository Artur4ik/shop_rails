# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, :first_name, :birthdate, presence: true
  has_many :carts, dependent: :delete_all
end
