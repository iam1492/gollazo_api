class DropSelectionsTable < ActiveRecord::Migration
  def up
  	drop_table :selections
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
