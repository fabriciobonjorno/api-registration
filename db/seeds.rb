# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Registering States'
10.times do
  State.find_or_create_by(
    name: Faker::Address.state,
    initials: Faker::Address.state_abbr
  )
end
sleep 5
puts 'Registered States'
puts '------------------'
puts 'Registering Cities'
10.times do
  City.find_or_create_by(
    name: Faker::Address.city,
    state_id: rand(1..10)
  )
end
sleep 5
puts 'Registered Cities'