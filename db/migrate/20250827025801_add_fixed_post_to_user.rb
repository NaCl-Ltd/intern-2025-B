class AddFixedPostToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fixed_post, :bigint
  end
end
