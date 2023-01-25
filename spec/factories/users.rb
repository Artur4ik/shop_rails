# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { FFaker::NameRU.first_name }
    last_name { FFaker::NameRU.last_name }
    password { '123' }
    email { FFaker::Internet.free_email }
    birthdate { '10.01.2001' }
    address { FFaker::AddressRU.city }
    admin { false }
  end
end
