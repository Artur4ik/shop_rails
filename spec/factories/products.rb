# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { FFaker::Vehicle.model }
  end
end
