
# Clean previous seeds
Chat.destroy_all
Game.destroy_all
Message.destroy_all
User.destroy_all

# Create users
10.times do
  User.create(email: Faker::Internet.email)
end

# 10.times do
#   Chat.create(user_id:rand(1..10),game_id:(1..10))
# end

10.times do
  Game.create(name:Faker::Game.title)
end


# create_table "chats", force: :cascade do |t|
#     t.bigint "user_id", null: false
#     t.bigint "game_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["game_id"], name: "index_chats_on_game_id"
#     t.index ["user_id"], name: "index_chats_on_user_id"
#   end

#   create_table "games", force: :cascade do |t|
#     t.string "name"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "messages", force: :cascade do |t|
#     t.text "send_message"
#     t.text "response_message"
#     t.bigint "chat_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["chat_id"], name: "index_messages_on_chat_id"
#   end

#   create_table "users", force: :cascade do |t|
#     t.string "email", default: "", null: false
#     t.string "encrypted_password", default: "", null: false
#     t.string "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["email"], name: "index_users_on_email", unique: true
#     t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
#   end
