require 'faker'

10.times do
 Article.create(
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
    )
end

puts "Seed finished"
puts "#{Article.count} articles created"
