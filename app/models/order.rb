# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
end
