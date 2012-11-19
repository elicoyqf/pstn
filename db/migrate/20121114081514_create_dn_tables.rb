class CreateDnTables < ActiveRecord::Migration
  def change
    create_table :dn_tables do |t|
      t.integer :jf_name_id
      t.integer :dn_start
      t.integer :dn_end

      t.timestamps
    end
  end
end
