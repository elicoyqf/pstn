class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :department_id, :integer
    add_column :users, :alias_name, :string
  end
end
