class AddColumnToLogbook < ActiveRecord::Migration
  def change
    add_column :logbooks, :log_type, :string
  end
end
