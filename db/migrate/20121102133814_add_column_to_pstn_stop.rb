class AddColumnToPstnStop < ActiveRecord::Migration
  def change
    add_column :pstn_stops, :type, :integer
    add_column :pstn_stops, :emerg, :integer
  end
end
