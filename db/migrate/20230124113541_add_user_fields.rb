# frozen_string_literal: true

class AddUserFields < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :address
    end
  end
end
