require 'faker'

# Clean previous seeds
puts "Cleaning..."
Message.delete_all
Chat.delete_all
Game.delete_all
User.delete_all

# So registros unicos
Faker::UniqueGenerator.clear

puts "Seeding users..."
admin_user = User.create!(email:"admin@admin.com",password:"123456")
users = 4.times.map do
  User.create!(email: Faker::Internet.unique.email, password:"123456")
end
users << admin_user


puts "Seeding games..."
games = 5.times.map do
   Game.create!(name: Faker::Game.unique.title, image: Faker::LoremFlickr.image(size: "200x400", search_terms: ['games']))
end

puts "Seeding chats..."
chats = users.map do |user|
   Chat.create!(user: user, game:games.sample)
end

puts "Seeding messages…"
chats.map do |chat|
  roles = %w[user assistant]
  5.times do
    chat.messages.create!(
      role: roles.sample,
      message: Faker::Lorem.sentence(word_count: 3)
    )
  end
end

puts "Users: #{User.count}, Games: #{Game.count}, Chats: #{Chat.count}, Messages: #{Message.count}"
