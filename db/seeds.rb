require 'faker'
require 'open-uri'

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
  image_url = "https://static.photos/gaming/1024x576/#{rand(54..168)}"
  io = URI.open(image_url)
   game = Game.create!(name: Faker::Game.unique.title)
   game.image.attach(
    io: io,
    filename:"game_#{rand(1000)}.jpg",
    content_type: "image/jpeg"
  )
  game.save!
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


require "open-uri"
