class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :category_code
      t.string :title
      t.string :description
      t.string :url_1
      t.string :url_2
      t.string :url_3
      t.string :url_4
      t.integer :vote_count_1
      t.integer :vote_count_2
      t.integer :vote_count_3
      t.integer :vote_count_4      
      t.string :rank
      t.integer :user_id

      t.timestamps
    end

    add_index :posts, :category_code
  end
end
