class AddUpdateIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :update_id, :integer
  end
end
