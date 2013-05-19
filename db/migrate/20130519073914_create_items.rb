class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.integer :score
      t.integer :post_id

      t.timestamps
    end
  end
end
