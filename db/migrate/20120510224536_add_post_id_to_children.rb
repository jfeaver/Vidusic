class AddPostIdToChildren < ActiveRecord::Migration
  def change
    add_column :videos, :post_id, :integer
    add_column :backgrounds, :post_id, :integer
  end
end
