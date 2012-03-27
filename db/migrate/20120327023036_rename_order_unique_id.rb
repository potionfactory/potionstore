class RenameOrderUniqueId < ActiveRecord::Migration
  def up
    rename_column :orders, :unique_id, :uuid
  end

  def down
    rename_column :orders, :uuid, :unique_id
  end
end
