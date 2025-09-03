class UpdateMessagesSchema < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :send_message, :text
    remove_column :messages, :response_message, :text

    add_column :messages, :role, :string
    add_column :messages, :message, :text
  end
end
