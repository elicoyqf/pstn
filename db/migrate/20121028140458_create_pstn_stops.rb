class CreatePstnStops < ActiveRecord::Migration
  def change
    create_table :pstn_stops do |t|
      t.integer :user_id
      t.string :sn
      t.string :status

      t.timestamps
    end
  end
end
