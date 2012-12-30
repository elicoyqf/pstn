class CreateLogbooks < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
