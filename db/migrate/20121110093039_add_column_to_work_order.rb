class AddColumnToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :priority, :integer
  end
end
