class RemovePostImageIdFromBookComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :book_comments, :post_image_id, :integer
  end
end
