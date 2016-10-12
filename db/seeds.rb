# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'admin@betacamp.co',
  password: 'secretsecret',
  password_confirmation: 'secretsecret',
  admin: true
)

providers = 5.times.map do
  ForeignProvider.create(
    name: Faker::Company.name,
    country: Faker::Address.country,
    state: Faker::Address.state_abbr,
    city: Faker::Address.city,
    street: Faker::Address.street_address,
    zip_code: Faker::Address.zip_code,
    telephone: Faker::PhoneNumber.phone_number
  )
end

I18n.with_locale(:'zh-TW') do
  5.times do
    providers << LocalProvider.create(
      name: Faker::Company.name,
      country: Faker::Address.country,
      city: Faker::Address.city,
      street: Faker::Address.street_address,
      zip_code: Faker::Address.zip_code,
      telephone: Faker::PhoneNumber.phone_number
    )
  end
end

categories = {
  'Books' => ['Programming', 'Comics', 'Novel', 'Literature'],
  'Clothes' => ['Hat', 'Pants', 'Coat', 'Jacket', 'Shoes'],
  '3C' => ['Computer', 'Mobile Phone', 'TV', 'Laptop', 'Tablet'],
  'Groceries' => ['Stationery', 'Tools', 'Doll', 'Toys'],
  'Food' => ['Noodle', 'Rice', 'Drinks', 'Vegetable']
}

categories.each do |name, subs|
  category = Category.create!(
    name: name, description: Faker::Lorem.sentences(rand(3..5)).join
  )

  subs.each do |subname|
    subcategory = category.children.create!(
      name: subname, description: Faker::Lorem.sentences(rand(3..5)).join
    )

    rand(12..18).times do
      subcategory.products.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentences(rand(3..5)).join,
        content: Faker::Lorem.paragraphs(rand(5..8)).join("\n"),
        price: Faker::Commerce.price * 30,
        active: true,
        shelved_on: Date.current,
        provider: providers.sample
      )
    end
  end
end

products = Product.all
user = User.first
5.times do ||
  order = user.orders.build(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    mobile: Faker::PhoneNumber.cell_phone
  )
  rand(3..8).times do
    product = products.sample
    order.order_items.build(product: product, price: product.price, quantity: rand(1..5))
  end
  order.amount = order.order_items.map { |x| x.price * x.quantity }.sum
  order.save!
end