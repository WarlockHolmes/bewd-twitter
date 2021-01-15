class AddMessageToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :message, :string
  end
end
