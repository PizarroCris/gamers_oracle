class RenameMessageInMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :message, :content
  end
end
