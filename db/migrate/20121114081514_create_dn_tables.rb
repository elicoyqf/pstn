class CreateDnTables < ActiveRecord::Migration
  def change
    create_table :dn_tables do |t|
      t.integer :jf_name_id
      t.string :dn_start
      t.string :dn_end

      t.timestamps
    end
  end
end
