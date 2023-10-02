# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "テスト",
    introduction: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    is_public: true,
    is_active: true,
    password: "000000"
  )
end

Admin.create!(
  email: 'test@test.com',
  password: '000000'
)