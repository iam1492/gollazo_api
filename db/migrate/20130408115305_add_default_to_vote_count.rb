class AddDefaultToVoteCount < ActiveRecord::Migration
	def up
	    change_column :posts, :vote_count_1, :integer, :default => 0
	    change_column :posts, :vote_count_2, :integer, :default => 0
	    change_column :posts, :vote_count_3, :integer, :default => 0
	    change_column :posts, :vote_count_4, :integer, :default => 0
	end

	def down
	    change_column :posts, :vote_count_1, :integer, :default => nil
	    change_column :posts, :vote_count_2, :integer, :default => nil
	    change_column :posts, :vote_count_3, :integer, :default => nil
	    change_column :posts, :vote_count_4, :integer, :default => nil
	end
end
