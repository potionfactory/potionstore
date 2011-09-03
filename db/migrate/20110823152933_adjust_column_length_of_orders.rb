class AdjustColumnLengthOfOrders < ActiveRecord::Migration
  def self.up
    change_column :orders, :failure_reason, :text
    change_column :orders, :address1, :string, :limit => 128, :default => ""
  end

  def self.down
    change_column :orders, :failure_reason, :string
    change_column :orders, :address1, :string, :limit => 64, :default => ""
  end
end
