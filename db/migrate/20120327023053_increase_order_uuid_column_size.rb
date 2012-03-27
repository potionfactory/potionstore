class IncreaseOrderUuidColumnSize < ActiveRecord::Migration
  def up
    change_column :orders, :uuid, :string, :limit => 36
  end

  def down
    change_column :orders, :uuid, :string, :limit => 16
  end
end
