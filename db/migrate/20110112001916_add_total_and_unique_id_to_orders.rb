def round_money(amount)
  return ("%01.2f" % amount).to_f()
end

class AddTotalAndUniqueIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :unique_id, :string, :limit => 16
    add_column :orders, :total, :decimal, :precision => 10, :scale => 2

    Order.reset_column_information

    Order.find(:all).each do |o|
      o.unique_id = uid()
      o.total = o.calculated_total
      o.skip_cc_validation = true
      o.save!
    end

    change_column :orders, :unique_id, :string, :limit => 16, :null => false
    change_column :orders, :total, :decimal, :precision => 10, :scale => 2, :null => false
  end

  def self.down
    remove_column :orders, :total
    remove_column :orders, :unique_id
  end
end
