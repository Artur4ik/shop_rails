# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :delete_all
  has_many :products, through: :orders
end
