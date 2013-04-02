class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fb_id,                :null => false
      t.string :first_name,           :default => ""
      t.string :last_name,            :default => ""
      t.string :name,                 :default => ""
      t.string :gender,               :default => ""
      t.string :profile_url,          :default => ""
      t.string :profile_thumbnail_url,:default => ""

      t.timestamps
    end

    add_index :users, :fb_id, :unique => true
    
  end
end
