require 'faker'

5.times do
  user = User.new(
    name:  Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end

users = User.all


10.times do
 Article.create(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
    )
end

5.times do
  Contributor.create(
    user: users.sample
    )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Article.count} articles created"
puts "#{Contributor.count} contributors created"