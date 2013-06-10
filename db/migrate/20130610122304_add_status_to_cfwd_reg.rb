class AddStatusToCfwdReg < ActiveRecord::Migration
  def change
    add_column :cfwd_regs, :status, :string
  end
end
