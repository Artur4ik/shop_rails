# frozen_string_literal: true

5.times do
  User.create!(
    first_name: FFaker::NameRU.first_name,
    last_name: FFaker::NameRU.last_name,
    email: FFaker::Internet.free_email,
    birthdate: '10.01.2001',
    password: '123'
  )

  ProductCategory.create!(
    name: FFaker::Company.name,
    description: FFaker::LoremRU.sentence
  )

  Product.create!(
    name: FFaker::Vehicle.model,
    product_category: ProductCategory.all.sample,
    description: FFaker::LoremRU.sentence
  )
end

cart = Cart.create!(
  user_id: 1
)

Order.create!(
  cart_id: cart.id,
  product_id: Product.all.sample.id
)
