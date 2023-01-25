# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(first_name:, email:, password_digest:, birthdate:, admin:) }

  let(:first_name) { 'Vasya' }
  let(:email) { 'test@example.com' }
  let(:password_digest) { 'qwerty' }
  let(:birthdate) { '18.01.1998' }
  let(:admin) { false }

  it 'return user email' do
    expect(user.email).to eq(email)
  end

  it 'return is user admin?' do
    expect(user.admin).to eq(admin)
  end

  it 'is valid' do
    expect(user).to be_valid
  end

  context 'when password is not present' do
    let(:password_digest) { '' }

    it 'is invalid' do
      expect(user).to be_invalid
    end
  end
end
