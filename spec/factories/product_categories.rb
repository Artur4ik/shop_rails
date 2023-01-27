# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name { FFaker::Company.name }
  end
end
