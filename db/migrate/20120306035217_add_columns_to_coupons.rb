class AddColumnsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :enabled, :boolean, :default => true
    add_column :coupons, :expiration_date, :timestamp
  end
  
  def self.down
    remove_column :coupons, :enabled, :boolean
    remove_column :coupons, :expiration_date, :timestamp
  end
end
