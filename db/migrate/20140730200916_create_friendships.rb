class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.string :follower_id
      t.string :followed_id

      t.timestamps
    end
  end
end
