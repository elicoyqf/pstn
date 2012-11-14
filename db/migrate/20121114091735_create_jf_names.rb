class CreateJfNames < ActiveRecord::Migration
  def change
    create_table :jf_names do |t|
      t.string :name
      t.string :ip_address
      t.integer :status
      t.timestamps
    end
  end
end
