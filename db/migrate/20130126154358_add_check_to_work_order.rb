class AddCheckToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :check, :integer
  end
end
