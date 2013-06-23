class ChangePostColounm < ActiveRecord::Migration
  change_table :posts do |t|  
     t.change :description, :text
  end
end
