class RenameColumnToPstnStop < ActiveRecord::Migration
  def up
    rename_column :pstn_stops, :type, :work_order_t
  end

  def down
    rename_column :pstn_stops, :work_order_t, :type
  end
end
