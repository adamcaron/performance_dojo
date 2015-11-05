class AddArticleIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :article_id
    add_index :taggings, :article_id
  end
end
