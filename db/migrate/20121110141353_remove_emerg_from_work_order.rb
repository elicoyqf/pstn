class RemoveEmergFromWorkOrder < ActiveRecord::Migration
  def up
    remove_column :work_orders, :emerg
  end

  def down
    add_column :work_orders, :emerg, :string
  end
end
