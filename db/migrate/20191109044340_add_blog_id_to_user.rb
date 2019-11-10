class AddBlogIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blog_id, :integer
    add_index :users, :blog_id
  end
end
