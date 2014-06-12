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

# 5.times do
#   Contributor.create(
#     user: users.sample
#     )
# end


# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save

# Create a premium
moderator = User.new(
  name:     'Premium User',
  email:    'premium@example.com', 
  password: 'helloworld',
  role:     'premium'
)
moderator.skip_confirmation!
moderator.save

# Create a member
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Article.count} articles created"
puts "#{Contributor.count} contributors created"